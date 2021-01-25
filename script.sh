#! /bin/bash -

# Preparo la lista di tutti i commit
git log --pretty=oneline > lista.txt
cat lista.txt
# Cancello i valori dopo il primo spazio per ogni riga
grep -o '^\S*' lista.txt > lista_new.txt
# Cancello gli spazi extra tra ogni riga
grep -v '^ *$' lista_new.txt > lista.txt
rm lista_new.txt

tail -r lista.txt > lista_invertita.txt
mv lista_invertita.txt lista.txt 

mkdir venv
virtualenv -p python3 venv
source venv/bin/activate
# Verificare presenza di pip altrimenti installarlo
# python -m pip install --upgrade pip
pip install -r requirements.txt

touch report.txt
# Ciclo per ogni commit
while IFS= read -r LINE; do
    git checkout "$LINE"
    python -m jupyter nbconvert *.ipynb --to python --output-dir="output_py"
    flake8 output_py --count --select=E231,E501,W293,W291,E225,E251,E703,E261,E265,E128,F82 --statistics --output-file=output.txt
    echo “—————————“ >> report.txt
    echo "$LINE" >> report.txt
    cat output.txt >> report.txt
    echo “—————————“ >> report.txt
    rm output.txt
    rm -Rf output_py
done < lista.txt

