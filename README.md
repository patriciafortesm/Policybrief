# policybrief

Create professional, publication-ready policy briefs as standalone HTML documents — directly from R.

Designed for **researchers and public policy managers** who need to communicate research findings to non-specialized audiences, following World Bank and international best practices.

## Installation

```r
devtools::install_github("patriciafortesm/policybrief")
```

## Example output

![Policy Brief Example](man/figures/example_policy_brief.png)

*Generated entirely from R — cover, executive summary, key findings, recommendations, and back cover.*

## Example (English)

```r
library(policybrief)

policy_brief(
  title = "School Dropout Among Vulnerable Youth",
  primary_color = "#1565C0",
  accent_color  = "#FF8F00",
  lang = "en",
  pages = list(

    pb_cover(
      title = "School Dropout Among Vulnerable Youth",
      subtitle = "Evidence from Administrative Education Records, 2010-2022",
      cover_image = "photo.jpg",
      logo = "logo.png"
    ),

    pb_about(
      text = c(
        "This policy brief was prepared by the INEDU research team.",
        "The views expressed are those of the authors."
      ),
      institution_name = "INEDU - Institute for Education Research",
      institution_description = "An independent research institute dedicated to
        producing evidence to inform education and social policies."
    ),

    pb_section(
      title = "Executive Summary",
      icon = "summary",
      content = c(
        "School dropout is one of the most pressing challenges in education
         systems across developing countries. Among low-income families,
         dropout rates are significantly higher than the national average.",
        "This study analyzed over 8 million education trajectories of
         adolescents aged 10 to 17 from low-income families."
      ),
      highlight = "3 out of every 10 adolescents from low-income families
                    do not complete basic education.",
      stats = list(
        "Adolescents followed" = "8.2M",
        "Dropout rate" = "29%",
        "Municipalities" = "5,570"
      )
    ),

    pb_section(
      title = "Key Findings",
      subtitle = "What the data reveals about dropout patterns",
      icon = "findings",
      findings = list(
        "Gender gap" = "Boys are 40% more likely to drop out than girls.",
        "Race and ethnicity" = "Minority adolescents show 1.8x higher dropout rates.",
        "Regional disparities" = "Disadvantaged regions concentrate 62% of cases.",
        "Cash transfers" = "Transfer recipients showed 15% lower dropout."
      )
    ),

    pb_section(
      title = "Policy Recommendations",
      icon = "recommendations",
      content = "Based on our findings, we recommend:",
      recommendations = c(
        "Expand conditional cash transfer coverage for adolescents aged 14-17.",
        "Implement early warning systems to identify at-risk students.",
        "Develop targeted retention programs for boys in high informal labor regions.",
        "Strengthen equity policies within education."
      )
    ),

    pb_back_cover(
      institution_name = "INEDU - Institute for Education Research",
      website = "https://www.inedu-research.org",
      email = "contact@inedu-research.org",
      logo = "logo.png"
    )
  )
)
```

## Exemplo (Portugues)

```r
library(policybrief)

policy_brief(
  title = "Evasao Escolar Entre Jovens Vulneraveis",
  primary_color = "#00695C",
  accent_color  = "#F57C00",
  lang = "pt",
  pages = list(

    pb_cover(
      title = "Evasao Escolar Entre Jovens Vulneraveis",
      subtitle = "Evidencias a partir de Registros Administrativos de Educacao, 2010-2022",
      doc_type = "RESUMO EXECUTIVO",
      cover_image = "foto.jpg",
      logo = "logo.png"
    ),

    pb_about(
      text = c(
        "Este resumo executivo foi elaborado pela equipe de pesquisa do INEDU.",
        "As opinioes expressas sao dos autores e nao representam necessariamente
         a posicao das instituicoes financiadoras."
      ),
      institution_name = "INEDU - Instituto de Pesquisa em Educacao",
      institution_description = "Instituto independente dedicado a producao de
        evidencias para informar politicas educacionais e sociais."
    ),

    pb_section(
      title = "Resumo Executivo",
      icon = "summary",
      content = c(
        "A evasao escolar e um dos maiores desafios dos sistemas educacionais
         em paises em desenvolvimento. Entre familias de baixa renda, as taxas
         de evasao sao significativamente maiores que a media nacional.",
        "Este estudo analisou mais de 8 milhoes de trajetorias educacionais
         de adolescentes de 10 a 17 anos de familias de baixa renda."
      ),
      highlight = "3 em cada 10 adolescentes de familias de baixa renda
                    nao completam o ensino basico.",
      stats = list(
        "Adolescentes acompanhados" = "8,2M",
        "Taxa de evasao" = "29%",
        "Municipios" = "5.570"
      )
    ),

    pb_section(
      title = "Principais Achados",
      subtitle = "O que os dados revelam sobre padroes de evasao",
      icon = "findings",
      findings = list(
        "Genero" = "Meninos tem 40% mais chance de evadir do que meninas.",
        "Raca e etnia" = "Adolescentes de minorias apresentam taxas 1,8x maiores.",
        "Disparidades regionais" = "Regioes desfavorecidas concentram 62% dos casos.",
        "Transferencia de renda" = "Beneficiarios de programas sociais tiveram 15% menos evasao."
      )
    ),

    pb_section(
      title = "Recomendacoes",
      icon = "recommendations",
      content = "Com base nos resultados, recomendamos:",
      recommendations = c(
        "Ampliar a cobertura de transferencia de renda para adolescentes de 14 a 17 anos.",
        "Implementar sistemas de alerta precoce para identificar alunos em risco de evasao.",
        "Desenvolver programas de retencao para meninos em regioes com alto trabalho informal.",
        "Fortalecer politicas de equidade na educacao.",
        "Integrar dados de registros sociais e censo escolar no nivel municipal."
      )
    ),

    pb_back_cover(
      institution_name = "INEDU - Instituto de Pesquisa em Educacao",
      website = "https://www.inedu-research.org",
      email = "contato@inedu-research.org",
      social = "@inedu_research",
      extra_text = "O INEDU produz evidencias cientificas para informar politicas
                    educacionais e de protecao social."
    )
  )
)
```

## How it works / Como funciona

A policy brief is built from **pages**, each created by a function:

| Function | Purpose / Finalidade |
|---|---|
| `pb_cover()` | Cover page with title, image, logo / Capa com titulo, imagem, logo |
| `pb_about()` | About/disclaimer page / Pagina sobre a publicacao |
| `pb_section()` | Content page / Pagina de conteudo (resumo, achados, recomendacoes) |
| `pb_back_cover()` | Back cover with contacts / Contracapa com contatos |

Add as many `pb_section()` pages as you need.

## Customization

### Colors

Change the entire look by setting just two colors:

```r
policy_brief(
  primary_color = "#2c3e50",  # main color / cor principal
  accent_color  = "#e74c3c",  # accent color / cor de destaque
  ...
)
```

### Section content types

Each `pb_section()` supports multiple content types that can be combined:

| Parameter | EN | PT |
|---|---|---|
| `content` | Text paragraphs | Paragrafos de texto |
| `highlight` | Colored box with key message | Caixa colorida com mensagem principal |
| `stats` | Big number callouts | Numeros em destaque |
| `findings` | Finding cards with titles | Cards de achados com titulos |
| `recommendations` | Numbered list | Lista numerada de recomendacoes |
| `image` | Figure with caption | Figura com legenda |
| `two_columns` | Two-column text layout | Layout em duas colunas |
| `footnotes` | Footnotes | Notas de rodape |
| `raw_html` | Custom HTML | HTML customizado |

### Section icons

Available: `summary` · `context` · `findings` · `recommendations` · `objectives` · `results` · `info` · `default`

## Output

The output is a **single standalone HTML file** with all images embedded as base64:

- No external dependencies — one file
- Works offline
- Easy to share by email
- Prints well (A4)
- Convert to PDF: browser Print > Save as PDF

## License

MIT
