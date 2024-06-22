import streamlit as st
import os
from load_process import load_process# Assuming preprocess.py defines preprocess_function

# Set the page configuration
st.set_page_config(page_title="Question Answerer using RAG", layout="wide")

UPLOAD_DIR = "uploads"
if not os.path.exists(UPLOAD_DIR):
    os.makedirs(UPLOAD_DIR)

# Sidebar for file upload
st.sidebar.title("Upload PDF Files")
uploaded_files = st.sidebar.file_uploader("Choose PDF files", accept_multiple_files=True, type="pdf")

if uploaded_files:
    for uploaded_file in uploaded_files:
        # Save each uploaded file to the upload directory
        save_path = os.path.join(UPLOAD_DIR, uploaded_file.name)
        with open(save_path, "wb") as f:
            f.write(uploaded_file.getbuffer())
        st.sidebar.success(f"File '{uploaded_file.name}' saved successfully to '{UPLOAD_DIR}'!")

# Main page content
st.title("Question Answering from a pdf using RAG")

# User input for question
user_question = st.text_input("Enter your question about the PDF content:")
if st.button("Generate Answer"):
    if user_question.strip() == "":
        st.warning("Please enter a question.")
    else:
        st.info("Processing PDF files and generating answer... (this might take a moment)")
        answer = load_process(user_question)  # Call preprocess_function from preprocess.py
        st.info("Processing complete!")
        st.write("Answer:")
        st.write(answer)

st.write("Upload PDF files on the sidebar to analyze them.")
