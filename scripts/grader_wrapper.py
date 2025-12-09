import os
import pprint
import re, csv
import subprocess
from typing import Optional, Tuple, Dict, List
import pandas as pd
import datetime
from pathlib import Path

import csv
from collections import defaultdict

# def rename_file(filename):
#     # Split at the '_hw' which always marks the beginning of the second part
#     match = re.match(r'^(.*)(?=_hw.*)', filename)
#     if match:
#         before_hw = match.group(0)
#         after_hw = filename[len(before_hw):]
#         # Replace spaces with hyphens in the part before '_hw'
#         new_before = before_hw.replace(' ', '-')
#         new_filename = new_before + after_hw
#         os.rename(filename, new_filename)
#         print(f"{filename} Renamed to: {new_filename}")
#     else:
#         print("Filename does not match the expected pattern.")
#
#
# def rename_all(directory):
#     for subdir in os.listdir(directory):
#         if subdir.endswith("Cleaned"):
#             for file in os.listdir(os.path.join(directory, subdir)):
#                 rename_file(os.path.join(directory, subdir, file))


def grade_submission(
        solution_folder: str,
        submission_path: str
) -> Tuple[str, str]:
    """
    input: the path to the student submission, the path to the
           solution FOLDER
    output: the text output from the grader, and the path to the
            generated report as a string
    output: a tuple containing the grade obtained and an error if the
            grader did not successfully run. If the grader failed to run
            the grade obtained is -1
    """
    # report_name = os.path.relpath(submission_path, "/Users/jaylene/Desktop/LLM_Eval")
    # report_name = os.path.relpath(submission_path,'./F2022/exercises')



    # get rid of space
    # new_filename = submission_path.replace(" ", "-")
    # the report dir will be the same as the submission dir unless specified
    report_name = submission_path

    report_cmd = f'learn-ocaml grade --exercises={str(solution_folder)} --grade-student={str(submission_path)} --timeout 60 --dump-reports {report_name}'

    try:
        # print(f"running learn-ocaml grade ... ...")
        process = subprocess.run(report_cmd,
                                 shell=True,
                                 timeout=120,
                                 stdout=subprocess.PIPE,
                                 stderr=subprocess.STDOUT,
                                 check=False)
        # print(f"generating report {report_name}.report.txt ... ...")
        return process.stdout.decode('utf8'), f'{report_name}.report.txt'
    except (subprocess.TimeoutExpired, subprocess.CalledProcessError):
        return '0', 'Error'




def extract_ocaml_code(input, output):

    text = open(input, "r").read()
    # Regular expression to match OCaml code blocks
    # pattern = r'```ocaml\n(.*?)```'
    pattern = r'```(?:ocaml)?\n(.*?)```'

    # Extract all matches and join them with newline separators if match found
    matches = re.findall(pattern, text, re.DOTALL | re.IGNORECASE)
    out = open(output, "w")
    if len(matches) > 0:
        out.write('\n\n'.join(matches))

    # if not found, just write the original text to output
    else:
        out.write(text)

    out.close()

def extract_all(dir_path):
    # Iterate through all .txt files
    for subdir in os.listdir(dir_path):
        if len(subdir) < 5:
            cleaned = f"{subdir}Cleaned"

            cleaned_dir = os.path.join(dir_path, cleaned)
            if not os.path.exists(cleaned_dir):
                print(f"creating a new dir {cleaned_dir}......")
                os.makedirs(cleaned_dir)

            for filename in os.listdir(os.path.join(dir_path, subdir)):
                # print(filename)

                if filename.endswith(".txt") and "report" not in filename:
                    filename_output = filename[:-4] + ".ml"

                    file_path = os.path.join(dir_path, subdir, filename)
                    output = os.path.join(cleaned_dir, filename_output)

                    extract_ocaml_code(file_path, output)



                    # do not overwrite files
                    #
                    # if filename_output not in os.listdir(cleaned_dir):
                    #     file_path = os.path.join(dir_path, subdir, filename)
                    #     output = os.path.join(cleaned_dir, filename_output)
                    #
                    #     extract_ocaml_code(file_path, output)


def detect_error(message):
    if re.search(r"This expression has type .* ", message):
        err_type = "Type Error"
    elif "expected to have type" in message:
        err_type = "Type Error"
    elif "Syntax error" in message:
        err_type = "Syntax Error"
    elif "Unbound value" in message:
        err_type = "Unbound value"
    else:
        err_type = "None"

    # Extract text after "Error in user code:"
    extracted_message = ""
    match = re.search(r"Error in user code:\s*\n(.*)", message, re.DOTALL)
    if match:
        extracted_message = match.group(1).strip()

    # Extract grade if no error is found
    grade = 0
    grade_match = re.search(r"- (?:Success|Failure) - (\d+) points", message)
    if grade_match:
        grade = int(grade_match.group(1))

    return grade, err_type, extracted_message

def check_empty_files(directory):
        for file in os.listdir(directory):
            file_path = os.path.join(directory, file)

            if file.endswith(".txt.report.ml"):
                os.remove(file_path)
                print(f"Deleted file: {file_path}")
            if file.endswith(".ml"):
                if os.path.isfile(file_path) and os.path.getsize(file_path) == 0:
                    print(f"Empty file: {file_path}")


def rename_all_files_with_dashes(directory):
    for sub in os.listdir(directory):
        if sub.endswith("Cleaned"):
            sub_dir = os.path.join(directory, sub)
            for filename in os.listdir(sub_dir):
                if filename.endswith(".ml"):
                    old_path = os.path.join(sub_dir, filename)
                    new_filename = filename.replace(" ", "-")
                    new_path = os.path.join(sub_dir, new_filename)
                    if new_filename != filename:
                        os.rename(old_path, new_path)
                        print(f"Renamed: {filename} -> {new_filename}")



def count_hw_rows_by_model(csv_file, hw_number, model_column="Filename", search_column=None):
    """
    Count rows containing hw_number grouped by model extracted from model_column.

    Parameters:
    - csv_file: path to CSV
    - hw_number: string to search (e.g. 'hw1')
    - model_column: column where model name is found (e.g. 'Filename')
    - search_column: specific column to search for hw_number; if None, search all columns

    Returns:
    - dict mapping model_name -> count of rows containing hw_number
    """
    counts = defaultdict(int)

    with open(csv_file, 'r', encoding='utf-8') as f:
        reader = csv.DictReader(f)
        for row in reader:
            # Extract model name: split by underscore, take first part
            model_name = row[model_column].split("_")[0]

            # Check if hw_number appears in specified column or anywhere
            if search_column:
                if hw_number in row[search_column]:
                    counts[model_name] += 1
            else:
                if any(hw_number in value for value in row.values()):
                    counts[model_name] += 1

    return dict(counts)

def extract_metadata(file_path):
    """
    From filename like Claude-3.7-Sonnet_hw1_q1a_answer_1.ml
    extract model = Claude-3.7-Sonnet, hw = hw1, question = q1a
    """
    name = file_path.stem  # remove .ml extension
    parts = name.split("_")
    model = parts[0]
    hw = parts[1]
    question = parts[2]  # e.g., q1a
    return model, hw, question

def append_result_to_csv(row, output_path):
    file_exists = output_path.exists()
    with open(output_path, "a", newline='') as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=["model", "hw", "question", "Grade", "Error Type", "Message"])
        if not file_exists:
            writer.writeheader()
        writer.writerow(row)

def process_all_submissions(base_dir, output_path):
    for hw_folder in base_dir.glob("hw*Cleaned"):
        for q_folder in sorted(hw_folder.iterdir()):
            # check if q_foler is a folder not a file
            if q_folder.is_dir():
                print(f"Processing: {q_folder} for {hw_folder.name}")
                if not q_folder.is_dir():
                    continue
                for submission_file in q_folder.glob("*.ml"):
                    model, hw, question = extract_metadata(submission_file)
                    # grade, error_type, message = grade_submission(submission_file)

                    message = grade_submission(os.path.join("./F2022/exercises", hw), submission_file)
                    grade, error_type, mes = detect_error(message[0])
                    row = {
                        "model": model,
                        "hw": hw,
                        "question": question,
                        "Grade": grade,
                        "Error Type": error_type,
                        "Message": mes
                    }
                    append_result_to_csv(row, output_path)


def main():

    # """1. extracted only code part and perform renaming"""
    # dir_path = "./part_of_hw"
    # extract_all(dir_path)
    #
    # '''rename files'''
    # rename_all_files_with_dashes(dir_path)

    output = grade_submission("./F2022/exercises/hw3", "./part_of_hw/hw3Cleaned/q1a/Claude-3.7-Sonnet_hw3_q1a_answer_1.ml")
    print(output[0])
    print("-------------------")
    print(detect_error(output[0]))


    ''' 2. run the grader, and get the error type'''


    # base_dir = Path("part_of_hw")
    # output_csv = Path("hw_results.csv")
    # process_all_submissions(base_dir, output_csv)


    '''2a(Optional). check empty'''

    # directory = "./part_of_hw/hw7Cleaned"  # Change this to your target directory
    # check_empty_files(directory)



    # check hw numbers
    # csv_path = "grades_from_report.csv"
    # hw_num = "hw1"
    # counts_by_model = count_hw_rows_by_model(csv_path, hw_num, model_column="Filename", search_column="Filename")
    #
    # for model, count in counts_by_model.items():
    #     print(f"Model: {model}, Count for {hw_num}: {count}")
    #
    #

    '''3. get full grade'''
    # for sub in os.listdir("./F2022/exercises"):
    #     if sub.startswith("hw"):
    #         sub_dir = os.path.join("./F2022/exercises", sub)
    #         grade_submission(sub_dir, os.path.join(sub_dir, "solution.ml"))
    #

    '''4. check error type for truncated code snippet (for code correction)'''
    # for file in os.listdir("code_fixing/Syntax Error files 2"):
    #     if file.endswith("ml"):
    #         hw = file.split('_')[0]
    #         filepath = os.path.join("code_fixing/Syntax\ Error\ files\ 2", file)
    #         sol_path = os.path.join("F2022/exercises", hw)
    #         print(filepath,":\n")
    #         print(grade_submission(sol_path, filepath)[0])
    #         print('\n')

    """next: grade from report"""

if __name__ == "__main__":
    main()