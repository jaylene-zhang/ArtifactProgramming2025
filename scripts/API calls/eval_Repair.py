from openai import OpenAI
import os
import pandas as pd
import datetime


client = OpenAI(
    base_url="https://openrouter.ai/api/v1",
    api_key="enter your key",
)


def get_res(mes, model):
    completion = client.chat.completions.create(
      # extra_headers={
      #   "HTTP-Referer": $YOUR_SITE_URL, // Optional, for including your app on openrouter.ai rankings.
      #   "X-Title": $YOUR_APP_NAME, // Optional. Shows in rankings on openrouter.ai.
      # },
      model=model,
      # messages=[
      #   {
      #     "role": "system",
      #   "content": "You are an AI assistant who helps students FIXING their OCaml programming exercise. "
      #              "You will be given the type of error in the following program (one of the syntax/type/logical error)"
      #              "If you think you can fix the code give your fixed code in OCaml code ONLY. DO NOT include any natural language for explanations."
      #               "If you are unable to fix it explain briefly why."},
      #
      #   { "role": "user",
      #     "content": mes
      #       }
      # ]

        messages=[
            {
                "role": "system",
                "content": "You are an AI assistant who helps students FIXING their OCaml programming exercise. "
                           "There are type error(s) in the code I am to give you."
                           "You will also be given the **error message** return by the OCaml compiler which contains more details of the mismatched types. However, you MUST IGNORE the position information in the first line of the message since I have truncated the buggy code so the info DOES NOT align with the buggy code anymore."
                           "If you think you **can** fix the code give your fixed code in OCaml code ONLY. DO NOT include any natural language for explanations."
                           "If you are **unable** to fix it explain briefly why."},

            {"role": "user",
             "content": mes
             }
        ]
    )
    if completion and completion.choices:
        return completion.choices[0].message.content
    else:
        print(f"no answers from the model {model}. ")
        return "None"


'''call the model and save the answer'''
def save_res(model, home_path, index, error_type):
    # subdir_path: ./code_fixing/Logical Error files
    subdir_path = os.path.join(home_path, f"{error_type} files") # subdir_path: Logical Error files

    print(f"________________Obtaining answer for {error_type} files in {subdir_path} from {model_names[index]} \n")



    for filename in os.listdir(subdir_path):
        if filename.endswith(".ml"):
            print(f"obtaining answer for {filename} ... ... ")

            now = datetime.datetime.now()
            print(now.time(), '\n')

            file_path = os.path.join(subdir_path, filename)


                # Read the content of the file
            with open(file_path, 'r') as file:
                    file_content = file.read()

            # Concatenate the message with the file content
            if error_type == "Type Error":
                row = df[df['Filename'] == filename]

                if not row.empty:
                    message = row['Message'].values[0]

                content = f"**Error Type in the following code: **{error_type}\n***compiler error message(IGNORE position info)**\n{message}\n**Buggy Code to be fixed**\n{file_content}"
            else:
                content = f"**Error Type in the following code: **{error_type}\n**Buggy Code to be fixed**\n{file_content}"


            for i in range(1, 2):

                # filename: hw1_buggy_code_13.ml
                output_filename = f"{model_names[index]}_{filename[:-3]}_answer_{i}.ml"
                qsn_path = os.path.join(home_path, f"Fixed {error_type}")

                if not os.path.exists(qsn_path):
                    # Create the directory
                    print(f"creating new path {qsn_path}.... \n")
                    os.makedirs(qsn_path)



                # if output_filename in os.listdir(qsn_path):
                #     print(f"{output_filename} already exists. Skipping this answer.")
                #     continue
                #
                # else:
                #     print(f"{output_filename} does not exist. Saving this answer.")
                output = get_res(content, model)  # Process the file content with fun_x


                # Save the output
                # output_path = os.path.join(qsn_path, output_filename)
                # print(output_path)

                with open(qsn_path + "/" + output_filename, 'w') as output_file:
                    output_file.write(output)


'''main function'''

models = [
    # "google/gemini-2.0-flash-001",
    # "meta-llama/llama-3.1-70b-instruct",
    # "anthropic/claude-3.7-sonnet",
    "openai/gpt-4o-2024-11-20",
    # "openai/o1",

    # "qwen/qwen-2.5-7b-instruct",
    # "google/gemini-flash-1.5-8b",
    # "openai/gpt-4o-mini",
    # "openai/o3-mini-high",
    # "meta-llama/llama-3.1-8b-instruct"
    ]

model_names = [

    # "Gemini 2.0 Flash",
    # "Llama3.3 70B",
    # "Claude 3.7 Sonnet",
    "GPT-4o",
    # "o1",
    #
    # "Qwen2.5 7B",
    # "Gemini 1.5 Flash 8B",
    # "GPT-4o-mini",
    # "o3 Mini",
    # "Llama3.1 8B"
]




# TODO: read the csv file containing error info into a pandas df
home_path = "./code_fixing"
error_type = "Syntax Error"
df = pd.read_csv(f"{home_path}/{error_type}.csv")

for index, model in enumerate(models):

    save_res(model, home_path, index, error_type)





#
# prompt = open("./questions/final_q1.txt", "r").read()
# print(prompt)
#
#
# res = get_res(prompt)
# print(res)





