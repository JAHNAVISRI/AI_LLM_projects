from langchain_openai import OpenAI 
from langchain.prompts import PromptTemplate
from langchain.chains import LLMChain
from langchain.chains import SequentialChain
import os

os.environ['OPENAI_API_KEY'] = 'Insert your key here'
llm = OpenAI(temperature=0.6)

def generate_restaurant_name_and_items(cuisine):
    prompt_template_name = PromptTemplate(
        input_variables=['cuisine'],
        template='I want to open a restaurant for {cuisine} food. Please suggest one name'
    )
    namechain = LLMChain(llm=llm, prompt=prompt_template_name, output_key='restaurant_name')
    
    prompt_template_items = PromptTemplate(
        input_variables=['restaurant_name'],
        template='I need a list of menu items in this {restaurant_name}. Please suggest item names'
    )
    fooditemchain = LLMChain(llm=llm, prompt=prompt_template_items, output_key='menu_items')

    chain = SequentialChain(
        chains=[namechain, fooditemchain],
        input_variables=['cuisine'],
        output_variables=['restaurant_name', 'menu_items']
    )
    
    response = chain({'cuisine': cuisine})
    return response

if __name__ == "__main__":
    print(generate_restaurant_name_and_items('Italian'))
