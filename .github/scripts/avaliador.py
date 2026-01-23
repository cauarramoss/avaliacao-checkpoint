import os
import google.generativeai as genai
from github import Github

# Configuração
GITHUB_TOKEN = os.getenv('GITHUB_TOKEN')
GEMINI_API_KEY = os.getenv('GEMINI_API_KEY')
REPO_NAME = os.getenv('REPO_NAME')
PR_NUMBER = int(os.getenv('PR_NUMBER'))

genai.configure(api_key=GEMINI_API_KEY)

def get_pr_diff():
    g = Github(GITHUB_TOKEN)
    repo = g.get_repo(REPO_NAME)
    pr = repo.get_pull_request(PR_NUMBER)
    
    # Pega o diff (mudanças do código)
    files_changed = []
    for file in pr.get_files():
        # Ignora arquivos de configuração ou lockfiles se quiser
        if file.filename.endswith(('.dart', '.js', '.ts', '.tsx', '.py')): 
            files_changed.append(f"Arquivo: {file.filename}\nAlterações:\n{file.patch}")
    
    return "\n---\n".join(files_changed), pr

def evaluate_code(diff_text):
    model = genai.GenerativeModel('gemini-2.5-flash') # Rápido e barato (free tier)
    
    # O PROMPT É A ALMA DO NEGÓCIO
    prompt = f"""
    Você é um professor sênior de Engenharia de Software focada em Mobile.
    Seu objetivo é avaliar o código de um aluno iniciante.
    
    Critérios de avaliação:
    1. Boas práticas e Clean Code.
    2. Clareza nos commits (se possível inferir).
    3. Arquitetura (verifique se não há lógica de negócios na UI).
    4. Potenciais bugs ou problemas de performance.
    
    Aqui está o DIFF do Pull Request (as mudanças feitas):
    {diff_text}
    
    Gere um feedback formatado em Markdown. Seja educado, didático, aponte o erro e dê o exemplo de como corrigir.
    Termine com uma nota de 0 a 10 baseada na qualidade do código apresentado.
    """
    
    response = model.generate_content(prompt)
    return response.text

def post_comment(pr, body):
    pr.create_issue_comment(body)

if __name__ == "__main__":
    diff_text, pr = get_pr_diff()
    if not diff_text:
        print("Nenhum arquivo de código relevante alterado.")
    else:
        review = evaluate_code(diff_text)
        post_comment(pr, f"## 🤖 Avaliação Automática do Gemini\n\n{review}")