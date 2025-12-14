#import "@preview/polylux:0.4.0": *

#import "@preview/polylux:0.4.0" as polylux
#import polylux: uncover, only

// Цвета ГУАП
#let guap-blue = rgb("#005aaa") 
#let guap-dark-blue = rgb("#1b3f95") 
#let guap-cyan = rgb("#00a9e0") 
#let guap-magenta = rgb("#c6168d") 
#let guap-red = rgb("#e30613") 

// Размеры и отступы
#let margin-x = 1.25cm
#let margin-top = 100pt // Отступ сверху для контента
#let margin-bottom = 40pt

// Плейсхолдер для значка
#let guap-icon-placeholder(size: 50pt) = {
  box(width: size, height: size, fill: gray.lighten(80%), radius: 0pt)[
    #align(center + horizon)[
      #text(fill: gray, size: size * 0.2)[Знак]
    ]
  ]
}


// Логотип для слайдов (маленький)
#let guap-logo-small() = {
  image("images/guap-logo.png", width: 80pt)
}

#let presentation(
  title: [],
  subtitle: [],
  author: [],
  body
) = {
  set document(title: "ГУАП Презентация", author: "ГУАП")
  set page(
    paper: "presentation-16-9", 
    margin: 0pt,
  )
  set text(font: "Arial", size: 20pt, lang: "ru")

  set list(marker: [#text(fill: guap-red)[•]])
  set figure.caption(separator: [. ], position: top)
  show figure.caption: set text(size: 14pt, weight: "bold", fill: guap-dark-blue)
  show figure.caption: set align(left)


  show figure.where(kind: image): set figure(supplement: "Рисунок")

  // --- Титульный слайд ---
  page(background: {
      image("images/title-bg.png", fit: "cover", width: 100%, height: 100%)
    
  })[

    // Заголовок
    #place(top + left, dx: margin-x, dy: 38%)[
      #block(width: 85%)[
        #set text(fill: guap-blue, weight: "medium", size: 36pt)
        #set par(leading: 0.35em)
        #title
      ]
    ]

    // Подзаголовок
    #place(top + left, dx: margin-x, dy: 66%)[
      #block(width: 80%)[
        #set text(fill: black, size: 18pt, weight: "regular")
        #set par(leading: 0.4em)
        #subtitle
        
        #if author != [] [
           #v(1em)
           #text(size: 18pt, author)
        ]
      ]
    ]

    // Год
    #place(bottom + right, dx: -margin-x, dy: -margin-x)[
      #text(fill: guap-red, size: 23pt, weight: "semibold", [#datetime.today().year()])
    ]
  ]

  // --- Настройки для обычных слайдов ---
  set page(
    margin: (top: margin-top, bottom: margin-bottom, left: margin-x, right: margin-x),
    background: {
       rect(width: 100%, height: 100%, fill: white)
    },
    // Хедер с логотипом
    header: context {
      place(top + right, dx: 0pt, dy: 30pt)[ // 20pt от верха страницы
         #guap-logo-small()
      ]
    },
    // Футер с номером страницы
    footer: context {
      align(right)[
        #text(size: 12pt, fill: rgb("002755"))[
           #counter(page).display()
        ]
      ]
    }
  )
  show emph: set text(fill: guap-blue)
  
  body
}

// --- Функции слайдов ---

// Базовый слайд
#let slide(title: auto, content) = {
  polylux.slide[
    // Заголовок
    #if title != auto [
       #place(top + left, dx: 0pt, dy: -65pt)[
          #block(width: 100%)[
             #text(fill: guap-blue, size: 24pt, weight: "bold", title)
             #v(-12pt)
             #line(length: 100%, stroke: (paint: guap-blue, thickness: 1.5pt))
          ]
       ]
    ]
    
    // Контент
    #set text(size: 18pt, fill: black, weight: "regular")
    #set par(leading: 0.5em, justify: false)
    #content
  ]
}

// Слайд с двумя колонками
#let slide-cols(title: auto, left-col, right-col, fraction: (1fr, 1fr)) = {
  slide(title: title)[
    #grid(
      columns: fraction,
      gutter: 30pt,
      left-col,
      right-col
    )
  ]
}

// Слайд "Текст и рисунок"
#let slide-text-image(title: auto, text-content, image-content, caption: none, kind: image) = {
  slide(title: title)[
    #grid(
      columns: (1.1fr, 1fr), // Тексту чуть больше места
      gutter: 30pt,
      [
        #text-content
      ],
      [
        #figure(
        block(width: 100%, height: 100%)[ // Фиксированная высота для примера
           #layout(size => {
              block(
                 width: 100%, 
                 height: auto, // высота по контенту или фиксированная
                 clip: true,
                 radius: (top-left: 60pt, rest: 0pt), // Скругление как на макете
                 image-content
              )
           })
        ],
          caption: caption,
          kind: image
        )
      ]
    )
  ]
}

// Вспомогательные стили текста из макета
#let txt-subtitle(content) = text(fill: guap-dark-blue, style: "italic", size: 20pt, content)
