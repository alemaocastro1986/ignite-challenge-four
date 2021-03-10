
[<img src="https://raw.githubusercontent.com/alemaocastro1986/ignite-challenge-one/main/assets/elixir_full.png" width="180"/>]() 
# Desafios Elixir - Chapter I
## Sobre
Desafios Ignite [Rocketseat](https://rocketseat.com.br/)  trilha elixir __Chapter I__ .


## Desafio 03 - Workday reports parallel

O usuário deverá gerar um relatório a partir da leitura de varios arquivos `.csv`, utilizando __PARALELISMO__.

Dez pessoas fizeram freelas para uma empresa X durante cinco anos e o histórico com todos os dados de cada uma dessas pessoas (nome, horas trabalhadas, dia, mês e ano) foram passadas para um arquivo CSV na seguinte ordem: nome, horas de trabalho no dia (que vai variar de 1 a 8 hs), dia (que vai variar de 1 a 30 mesmo para o mês de fevereiro e sem considerar anos bissextos) referente às horas de trabalho, mês e ano (que vai de 2016 a 2020). Resumindo: **nome**, **quantidade de horas**, **dia**, **mês** e **ano**.
<br>
O relatório gerado a partir do arquivo deve estar no seguinte formato:

```elixir
%{
  all_hours: %{
        danilo: 500,
        rafael: 854,
        ...
    },
  hours_per_month: %{
        danilo: %{
            janeiro: 40,
            fevereiro: 64,
            ...
        },
        rafael: %{
            janeiro: 52,
            fevereiro: 37,
            ...
        }
    },
  hours_per_year: %{
        danilo: %{
            2016: 276,
            2017: 412,
            ...
        },
        rafael: %{
            2016: 376,
            2017: 348,
            ...
        }
    }
}
```

## Testando
```
mix test
```