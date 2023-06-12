from sentence_transformers import SentenceTransformer
from sklearn.metrics.pairwise import cosine_similarity
import os

# GPT 3
# CodeBERT
model_name = 'bert-base-nli-mean-tokens'


def list_all_job_descriptions_text():
    # Set the path to the folder containing the PDF files
    folder_path = 'Job_description_TXT'

    # Get a list of all the files in the folder
    files = os.listdir(folder_path)

    # Filter the list to include only PDF files
    pdf_files = [file for file in files if file.endswith('.txt')]

    # Print the names of the PDF files
    for file in pdf_files:
        print(file)


def calculate_similarity():
    job_description_name = input("Enter Job description Name: ")
    with open('Job_description_TXT/' + job_description_name, 'r', encoding='utf-8') as g:
        job_description_text = g.read()

    folder_path = 'CVs_TXT'

    cv_texts = []
    file_list = os.listdir(folder_path)
    for file_name in file_list:
        if file_name.endswith('.txt'):
            file_path = os.path.join(folder_path, file_name)
            with open(file_path, 'r', encoding='utf-8') as file:
                text = file.read()
                cv_texts.append((file_name, text))

    model = SentenceTransformer(model_name)
    cv_encodings = model.encode([text for _, text in cv_texts]).reshape(len(cv_texts), -1)
    job_encoding = model.encode(job_description_text).reshape(1, -1)

    # calculate similarity scores
    similarity_scores = cosine_similarity(cv_encodings, job_encoding)

    # create a list of lists containing (filename, similarity score)
    similarity_score = []
    for i, (cv_name, _) in enumerate(cv_texts):
        similarity_score.append(similarity_scores[i][0])

    return similarity_score
