import os
from llama_index.core import VectorStoreIndex,SimpleDirectoryReader
from llama_index.core.retrievers import VectorIndexRetriever
from llama_index.core.query_engine import RetrieverQueryEngine
from llama_index.core.indices.postprocessor import SimilarityPostprocessor

# # Set your API key directly here
os.environ['OPENAI_API_KEY'] = "Enter your key here"

def load_process(user_question):
    documents = SimpleDirectoryReader("uploads").load_data()
    index=VectorStoreIndex.from_documents(documents,show_progress=True)
    query_engine=index.as_query_engine()
    retriever=VectorIndexRetriever(index=index,similarity_top_k=4)
    postprocessor=SimilarityPostprocessor(similarity_cutoff=0.80)
    query_engine=RetrieverQueryEngine(retriever=retriever,
                                  node_postprocessors=[postprocessor])
    response=query_engine.query(user_question)
    print(response)
    return response

