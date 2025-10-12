# convert_utf8.py
with open('datos.json', 'r', encoding='latin1') as f:
    data = f.read()

with open('datos_utf8.json', 'w', encoding='utf-8') as f:
    f.write(data)
