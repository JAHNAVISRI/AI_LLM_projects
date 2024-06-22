import os
from llama_index.core import VectorStoreIndex,SimpleDirectoryReader
from llama_index.core.retrievers import VectorIndexRetriever
from llama_index.core.query_engine import RetrieverQueryEngine
from llama_index.core.indices.postprocessor import SimilarityPostprocessor
from llama_index.core.response.pprint_utils import pprint_response

# # Set your API key directly here
os.environ['OPENAI_API_KEY'] = "Enter your key here"

def load_process(user_question):
    documents = SimpleDirectoryReader("uploads").load_data()
    print(documents)
    index=VectorStoreIndex.from_documents(documents,show_progress=True)
    print(index)
    query_engine=index.as_query_engine()
    print(query_engine)
    retriever=VectorIndexRetriever(index=index,similarity_top_k=4)
    print(retriever)
    postprocessor=SimilarityPostprocessor(similarity_cutoff=0.80)
    query_engine=RetrieverQueryEngine(retriever=retriever,
                                  node_postprocessors=[postprocessor])
    print("what is the summary of files in 100 words")
    response=query_engine.query(user_question)
    print(response)
    pprint_response(response,show_source=True)
    print(pprint_response)
    return response

