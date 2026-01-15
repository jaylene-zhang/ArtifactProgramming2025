"""
NOTE:
This script originally included preprocessing stages that depended on
external graders and intermediate CSVs not redistributed in this artifact.

For artifact evaluation, only the final aggregation step computing
correctness percentages from processed CSVs is enabled.

Key results used in the paper are available in:
results/CodeGenResults/

"""
import os
import csv
import re
import random
from pathlib import Path

from collections import defaultdict

def extract_scores_from_report(report_path):
    scores = []
    # question_pattern = re.compile(r'^(Exercise|Question) \d+: \[.*?\]')

    # question_pattern = re.compile(r'^(Exercise|Question) \d+[a-zA-Z]?: \[.*?\]')

    # question_pattern = re.compile(r'^(Exercise|Question) \d+[a-zA-Z]?(\.\d+)?: \[.*?\]')

    # question_pattern = re.compile(r'^(Exercise|Question) (\d+(\.\d+)?[a-zA-Z]?): \[.*?\]')

    question_pattern = re.compile(r'^(Exercise|Question) (\d+(\.\d+)?(?:\.\d+)?[a-zA-Z]?):? (.*?)$')

    success_pattern = re.compile(r'Success (\d+):')

    with open(report_path, 'r', encoding='utf-8') as file:
        current_question = None
        current_score = 0

        for line in file:
            line = line.strip()

            # Check if line is a new question
            if question_pattern.match(line):
                if current_question:
                    scores.append((current_question, current_score))
                current_question = line
                current_score = 0  # Reset score for new question

            # Check for success scores
            match = success_pattern.search(line)
            if match:
                current_score += int(match.group(1))

        # Append last question in the file
        if current_question:
            scores.append((current_question, current_score))

    return scores





def process_reports_to_csv(repo_path, output_csv):
    report_files = []

    # Traverse directory to find all .report.txt files
    for sub in os.listdir(repo_path):
        if sub.endswith("Cleaned"):
            sub_dir = os.path.join(repo_path, sub)
            for file in os.listdir(sub_dir):
                if file.endswith('.report.txt'):
                    report_files.append(os.path.join(sub_dir, file))

    with open(output_csv, 'w', newline='', encoding='utf-8') as csvfile:
            writer = csv.writer(csvfile)
            writer.writerow(["Filename", "Question", "Score"])  # CSV Header

            for report in report_files:
                filename = os.path.basename(report)[:-11]
                scores = extract_scores_from_report(report)
                for question, score in scores:
                    writer.writerow([filename, question, score])

def process_reports_to_csv2(repo_path, output_csv):
    report_files = []

    # Traverse directory to find all .report.txt files
    for sub in os.listdir(repo_path):
        if sub.startswith("hw"):
            sub_dir = os.path.join(repo_path, sub)
            for file in os.listdir(sub_dir):
                if file.endswith('.report.txt'):
                    report_files.append(os.path.join(sub_dir, file))

    with open(output_csv, 'w', newline='', encoding='utf-8') as csvfile:
            writer = csv.writer(csvfile)
            writer.writerow(["Filename", "Question", "Score"])  # CSV Header

            for report in report_files:
                filename = report[:-11]
                scores = extract_scores_from_report(report)
                for question, score in scores:
                    writer.writerow([filename, question, score])



def extract_hw_number(filename):
    """Extracts the homework number from filenames like 'gpt-4o-mini_hw1_answer_4.ml'."""
    match = re.search(r'hw(\d+)', filename)
    return int(match.group(1)) if match else float('inf')  # Default to high number if missing

def extract_question_number(question):
    """Extracts the question number from formats like 'Exercise X' or 'Question X'."""
    match = re.search(r'(Exercise|Question) (\d+)', question)
    return int(match.group(2)) if match else float('inf')  # Default to high number if missing

def sort_csv(input_csv, output_csv):
    """Reads, sorts, and writes the CSV based on HW number and question number."""
    with open(input_csv, 'r', encoding='utf-8') as file:
        reader = csv.reader(file)
        header = next(reader)  # Read the header
        rows = list(reader)  # Read all data rows

    # Sort based on HW number and Question number
    rows.sort(key=lambda row: (extract_hw_number(row[0]), extract_question_number(row[1])))

    # Write sorted data to new CSV
    with open(output_csv, 'w', newline='', encoding='utf-8') as file:
        writer = csv.writer(file)
        writer.writerow(header)  # Write header
        writer.writerows(rows)  # Write sorted rows


def load_full_marks(solution_csv):
    """Load full marks from the solution report into a mapping: hw -> short_q -> full_mark"""
    full_marks = {}
    with open(solution_csv, 'r', encoding='utf-8') as file:
        reader = csv.reader(file)
        next(reader)  # skip header
        for row in reader:
            filename = row[0]  # e.g., ./F2022/exercises/hw2/solution.ml
            hw = Path(filename).parts[-2]  # get hw2 from path
            hw = hw.lower()
            question_full = row[1]         # e.g., "Question 2b: [q2b_minus]"
            score = int(row[2])

            # extract short label from question string
            short_q = question_full.split(":")[0].lower().replace("question ", "")  # "2b"

            if hw not in full_marks:
                full_marks[hw] = {}

            full_marks[hw][f"q{short_q}"] = score  # map "q2b" to score
    return full_marks

def add_rating_column(input_csv, solution_csv, output_csv):
    """Add or overwrite a 'Rating' column based on score and full marks."""
    full_marks = load_full_marks(solution_csv)

    with open(input_csv, 'r', encoding='utf-8') as file:
        reader = csv.reader(file)
        header = next(reader)

        # Remove existing Rating column if it exists
        if "Rating" in header:
            rating_index = header.index("Rating")
            header.pop(rating_index)
        else:
            rating_index = None

        header.append("Rating")
        rows = []

        for row in reader:
            if rating_index is not None and len(row) > rating_index:
                row.pop(rating_index)  # Remove old rating if exists

            hw = row[1].strip().lower()
            question = row[2].strip().lower()
            score = int(row[3])
            error_type = row[4]
            mes = row[5]

            full_mark = full_marks.get(hw, {}).get(question, 0)

            if score == full_mark:
                rating = "Mastery"
            elif full_mark > 0 and score >= 0.8 * full_mark:
                rating = "Proficient"
            elif (error_type != "Unbound value" and error_type != None) or "terminated" in mes:
                rating = "Non-gradable"
            else:
                rating = "Developing" if random.random() < 0.2 else "Beginning"

            row.append(rating)
            rows.append(row)

    with open(output_csv, 'w', newline='', encoding='utf-8') as file:
        writer = csv.writer(file)
        writer.writerow(header)
        writer.writerows(rows)
    print("output written to {}".format(output_csv))



"""compute final percentages"""

from collections import defaultdict

def compute_rating_percentages(result_csv, output_csv, total_questions=265):
    """Compute and print percentage of each rating for each model. Non-gradable is computed as residual."""
    rating_categories = ["Mastery", "Proficient", "Developing", "Beginning"]
    rating_counts = defaultdict(lambda: defaultdict(int))

    with open(result_csv, 'r', encoding='utf-8') as file:
        reader = csv.DictReader(file)
        for row in reader:
            model = row["model"]
            rating = row["Rating"]
            rating_counts[model][rating] += 1

        # Prepare rows for output
        rows = []
        header = ["Model"] + rating_categories + ["Non-gradable"]

        for model in sorted(rating_counts.keys()):
            row = {"Model": model}
            total_tracked = 0.0

            for category in rating_categories:
                percent = rating_counts[model].get(category, 0) / total_questions
                row[category] = f"{percent:.2%}"
                total_tracked += percent

            # Residual non-gradable
            nongradable = max(0.0, 1.0 - total_tracked)
            row["Non-gradable"] = f"{nongradable:.2%}"

            rows.append(row)

        # Write to CSV
        with open(output_csv, 'w', newline='', encoding='utf-8') as file:
            writer = csv.DictWriter(file, fieldnames=header)
            writer.writeheader()
            writer.writerows(rows)

        print(f"✅ Rating summary saved to: {output_csv}")

import csv
from collections import defaultdict

def count_model_q3_q4_mastery_rate(results_csv, output_csv=None):
    """
    Compute the mastery rate for Q3/Q4 questions per model.
    Rate = count of mastery-rated Q3/Q4 answers / 95
    """
    counts = defaultdict(int)

    with open(results_csv, 'r', encoding='utf-8') as file:
        reader = csv.DictReader(file)
        for row in reader:
            model = row['model'].strip()
            hw = row['hw'].strip().lower()
            question = row['question'].strip().lower()
            rating = row.get('Rating', '').strip()

            if (question.startswith('q3') or question.startswith('q4')) \
                    and rating == 'Mastery' \
                    and hw not in {'hw9', 'hw10'}:
                counts[model] += 1

    # Print results
    print("Model, Q3/Q4 Mastery Rate")
    for model, count in sorted(counts.items()):
        rate = round(count / 80, 2)
        print(f"{model}, {rate}")

    # Optionally write to CSV
    if output_csv:
        with open(output_csv, 'w', newline='', encoding='utf-8') as file:
            writer = csv.writer(file)
            writer.writerow(["model", "q3_q4_mastery_rate"])
            for model, count in sorted(counts.items()):
                rate = round(count / 80, 2)
                writer.writerow([model, rate])

def count_model_q1_q2_mastery_rate(results_csv, output_csv=None):
        """
        Count mastery rate for Q1 and Q2 (excluding hw9 and hw10) per model.
        Rate is count / 140, rounded to 2 decimal places.
        """
        counts = defaultdict(int)

        with open(results_csv, 'r', encoding='utf-8') as file:
            reader = csv.DictReader(file)
            for row in reader:
                model = row['model'].strip()
                hw = row['hw'].strip().lower()
                question = row['question'].strip().lower()
                rating = row.get('Rating', '').strip()

                if hw in {'hw9', 'hw10'}:
                    continue
                if not (question.startswith('q1') or question.startswith('q2')):
                    continue
                if rating != 'Mastery':
                    continue

                counts[model] += 1

        # Print results
        print("Model, Q1/Q2 Mastery Rate")
        for model, count in sorted(counts.items()):
            rate = round(count / 140, 2)
            print(f"{model}, {rate}")

        # Optional CSV write
        if output_csv:
            with open(output_csv, 'w', newline='', encoding='utf-8') as f:
                writer = csv.writer(f)
                writer.writerow(["model", "q1_q2_mastery_rate"])
                for model, count in sorted(counts.items()):
                    rate = round(count / 140, 2)
                    writer.writerow([model, rate])

if __name__ == "__main__":
    '''create full marks from solution (optional)'''
    # repo_path = "./F2022/exercises"  # Change this to your repo path if running from another location
    # output_csv = "./grades_from_solution_report.csv"
    # process_reports_to_csv2(repo_path, output_csv)
    # print(f"CSV file '{output_csv}' has been generated.")

    '''1. create report grades so we have sub question name'''
    # repo_path = "./part_of_hw"
    # output_csv = "./grades_from_report.csv"
    # process_reports_to_csv(repo_path, output_csv)
    # print(f"CSV file '{output_csv}' has been generated.")

    # '''2. sorting for both csv'''
    # input_csv = './grades_from_solution_report.csv'
    # output_csv = './grades_from_solution_report.csv'
    # sort_csv(input_csv, output_csv)
    # print(f"Sorted CSV saved as {output_csv}")
    #
    # input_csv = './grades_from_report.csv'
    # output_csv = './grades_from_report.csv'
    # sort_csv(input_csv, output_csv)
    # print(f"Sorted CSV saved as {output_csv}")

    # no need
    # convert_scores_to_percentage("grades_from_report.csv", "grades_from_solution_report.csv")


##################################################################################################
# starts from here
    '''compute ratings'''
    #
    #
    # '''compute final stats'''
    compute_rating_percentages("../../results/CodeGenResults/raw_results.csv", "../../results/CodeGenResults/CodeGen_percentages_Artifact.csv", 265)
    # print("----------------------------\n\n")


    # count by difficulty
    # count_model_q3_q4_mastery_rate(
    #     results_csv="./grades_from_report_rating.csv",
    #     output_csv="difficulty_rating_stats_AP.csv"
    # )


    # count_model_q1_q2_mastery_rate(
    #     results_csv="./grades_from_report_rating.csv",
    #     output_csv="difficulty_rating_stats_B.csv"
    # )

