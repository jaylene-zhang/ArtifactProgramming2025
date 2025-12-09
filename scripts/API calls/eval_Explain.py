from openai import OpenAI
import os


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
      messages=[
        {
          "role": "system",
        "content": "I have some conceptual exam questions about OCaml. Please do the questions below. Keep your answers concise and short."
                   "Always give your solution first followed by an explanation.\n"},

        { "role": "user",
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
def save_res(model, subdir_path, index, output_path):
    print(f"----------------Obtaining answer from {model_names[index]} ... ... --------------\n")

    for filename in os.listdir(subdir_path):
        if filename.endswith(".txt") and '18' in filename:
            print(f"obtaining answer for {filename} ... ... ")
            file_path = os.path.join(subdir_path, filename)

            with open(file_path, 'r') as file:
                content = file.read()

            # messages = [{"role": "system",
            #     "content": "I have some exam questions for OCaml. Please do the questions. Keep your answer concise and short."},
            #     {"role": "user", "content": content}]



            for i in range(1, 6):
                output = get_res(content, model)

                # Create the output filename
                output_filename = f"{model_names[index]}_{filename[:-4]}_answer_{i}.txt"

                qsn_path = os.path.join(output_path,f"{filename[:-4]}")
                if not os.path.exists(qsn_path):
                    # Create the directory
                    print(f"creating new path {qsn_path}.... \n")
                    os.makedirs(qsn_path)

                # Save the output
                # output_path = os.path.join(qsn_path, output_filename)
                # print(output_path)

                with open("./" + qsn_path + "/" + output_filename, 'w') as output_file:
                    output_file.write(output)


'''main function'''
# models = [
#     "google/gemini-flash-1.5",
#           "google/gemini-flash-1.5-8b",
#           "meta-llama/llama-3.1-70b-instruct",
#           "meta-llama/llama-3.1-8b-instruct",
#           "anthropic/claude-3.5-sonnet",
#           "anthropic/claude-3.5-haiku-20241022",
#           "mistralai/pixtral-large-2411",
#           "infermatic/mn-inferor-12b",
#           "openai/gpt-4o-mini",
#         "openai/gpt-4o-2024-11-20"
#     ]
#
# model_names = [
#     "gemini-flash-1.5",
#           "gemini-flash-1.5-8b",
#           "llama-3.1-70b-instruct",
#     "llama-3.1-8b-instruct",
#           "claude-3.5-sonnet",
#           "claude-3.5-haiku",
#           "pixtral-large",
#           "mn-inferor-12b",
#           "gpt-4o-mini",
#           "gpt-4o"]



models = [
    "google/gemini-2.0-flash-001",
    "meta-llama/llama-3.3-70b-instruct:free",
    "anthropic/claude-3.7-sonnet",
    "openai/gpt-4o-2024-11-20",
    # "openai/o1",

    "qwen/qwen-2.5-7b-instruct",
    "google/gemini-flash-1.5-8b",
    "openai/gpt-4o-mini",
    "openai/o3-mini-high",
    "meta-llama/llama-3.1-8b-instruct",
    ]

model_names = [

    "Gemini 2.0 Flash",
    "Llama3.3 70B",
    "Claude 3.7 Sonnet",
    "GPT-4o",
    # "o1",

    "Qwen2.5 7B",
    "Gemini 1.5 Flash 8B",
    "GPT-4o-mini",
    "o3 Mini",
    "Llama3.1 8B",

]

subdir_path = "./exam_questions"
output_path = "./exam_answers"
for index, model in enumerate(models):
    save_res(model, subdir_path, index, output_path)





#
# prompt = open("./questions/final_q1.txt", "r").read()
# print(prompt)
#
#
# res = get_res(prompt)
# print(res)





