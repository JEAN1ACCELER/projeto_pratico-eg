import webbrowser
import subprocess
import sys
import os

print("Iniciando ambiente de desenvolvimento...")
print("Carregando configurações...")

link = "https://aistudio.google.com/apps/52fb9770-f40f-47e8-911f-25d28ee90ba3?showPreview=true&showAssistant=true&fullscreenApplet=true"

# Tenta abrir especificamente no Chrome
try:
    if sys.platform == "win32":  # Windows
        chrome_path = "C:/Program Files/Google/Chrome/Application/chrome.exe"
        if os.path.exists(chrome_path):
            webbrowser.register('chrome', None, webbrowser.BackgroundBrowser(chrome_path))
            webbrowser.get('chrome').open(link)
        else:
            webbrowser.open(link)
    elif sys.platform == "darwin":  # Mac
        subprocess.run(['open', '-a', 'Google Chrome', link])
    else:  # Linux
        subprocess.run(['google-chrome', link])
    
    print(" Google Studio aberto no Chrome!")
except:
    # Se falhar, tenta abrir no navegador padrão
    webbrowser.open(link)
    print(" Link aberto no navegador padrão!")