# Crawler - Matrícula web UnB

Bibliotecas usadas:

- [Nokogiri](https://github.com/sparklemotion/nokogiri): Parser para HTML
- [Open-uri](https://ruby-doc.org/stdlib-2.1.0/libdoc/open-uri/rdoc/OpenURI.html): Requisições HTTP
- [Pry](https://github.com/pry/pry): Ferramenta de debug
- [json](https://rubygems.org/gems/json/versions/1.8.3?locale=pt-BR): Converter para JSON

Uma vez que tenha o ruby instalado, para obter a gemas digite no seu terminal:

```bash
gem install nokogiri
gem install pry
```

Open-uri é uma biblioteca nativa do Ruby, não há a necessidade de instalação.

Certifique-se que tenha o ruby e as gemas instaladas na sua máquina

Rode o programa no seu terminal com o comando:

```bash
ruby crawler.rb
```

Em seguida escolha a opção 1 ou 2 ou 3 ou 4 que correposnde respectivamente:

- 1 - Darcy Ribeiro
- 2 - Planaltina
- 3 - Ceilândia muita treta
- 4 - Gama

Saída:

```json
[
  {
    "department":"Centro de Desenvolvimento Sustentável  CDS",
    "code":"205761",
    "course":"Educação e Meio Ambiente ",
    "credits":"004-000-000-000",
    "name":"A",
    "schedules":["Segunda 20:50 22:40", "Quarta 20:50 22:40"],
    "teachers":[
      {
        "name":"IZABEL CRISTINA BRUNO BACELLAR ZANETI"
      }
    ]
  }
  .
  .
  .
]
```
