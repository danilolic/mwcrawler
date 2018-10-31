# Mwcrawler

Mwcrawler é uma gema para fazer o parsing dos dados do Matrícula Web da UnB e transformá-los em hashes que podem ser consumidos.

## Instalação

Adicione essa linha ao Gemfile da sua aplicação:

```ruby
gem 'mwcrawler'
```

E então rode o comando:

    $ bundle

Ou instale você mesmo utilizando:

    $ gem install mwcrawler

## Utilização

Primeiro instancie um novo crawler com `crawler = Mwcrawler::Crawler.new`
depois pode utilizar assim:
```ruby
courses_hash = crawler.courses
# return example
[{"type"=>"Presencial",
  "code"=>"19",
  "name"=>"ADMINISTRAÇÃO",
  "shift"=>"Diurno",
  "curriculums"=>
   [{"name"=>"Administração",
     "degree"=>"Bacharel",
     "semester_max"=>"8",
     "semester_min"=>"16",
     "credits"=>"200"}]},
 {"type"=>"Presencial",
  "code"=>"701",
  "name"=>"ADMINISTRAÇÃO",
  "shift"=>"Noturno",
  "curriculums"=>
   [{"name"=>"Administração",
     "degree"=>"Bacharel",
     "semester_max"=>"8",
     "semester_min"=>"16",
     "credits"=>"200"}]}
]
```
O campus padrão passado ao crawler é o `:darcy_ribeiro`, mas você pode especificar outro com `crawler.classes(:planaltina)`.

Os recursos disponíveis são `classes`, `courses` e `departments`. Além disso, pode ser escolhido qualquer um dos quatro campus `:darcy_ribeiro`, `:planaltina`, `:ceilandia` and `:gama`

## Desenvolvimento

Depois de dar checkout no repositório, rode `bin/setup` para instalar as dependências. Então, rode `rake spec` para rodar os testes. Adicionalmente, pode rodar `bin/console` para um console interativo que vai permitir a experimentação com a gema.

Para instalar essa gema na sua máquina local, rode `bundle exec rake install`. Para lançar uma nova versão, atualize a número da versão em `version.rb`, e depois rode `bundle exec rake release`, que vai criar uma tag no git para a versão, dê um push nos commits e nas tags, e dê um push no arquivo `.gem` para [rubygems.org](https://rubygems.org).

## Contribuindo

Reportar bugs e fazer pull requests são bem-vindas no Github em https://github.com/danilodelyima/mwcrawler.

## License

Essa gema está disponível como código aberto sob os termos da licença
[MIT License](https://opensource.org/licenses/MIT).
