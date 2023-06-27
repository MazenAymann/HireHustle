from extract_pdf import extract_all
from sentence_trans import list_all_job_descriptions_text, calculate_similarity
import os


def calc_similarity(job_description_input, job_description_output, cv_input, cv_output):
    folders = [job_description_input, job_description_output, cv_input, cv_output]

    for name in folders:
        if not os.path.exists(name):
            os.makedirs(name)

    extract_all(job_description_input, job_description_output)
    extract_all(cv_input, cv_output)

    list_all_job_descriptions_text()
    similarity_values = calculate_similarity()

    # convert each similarity_value to a percentage
    similarity_percentage = [f'{round(f * 100)}%' for f in similarity_values]

    return similarity_percentage
