
// Цвета ГУАП
#let guap-blue = rgb("#005eb8") 
#let guap-dark-blue = rgb("#1b3f95") 
#let guap-cyan = rgb("#00a9e0") 
#let guap-magenta = rgb("#c6168d") 
#let guap-red = rgb("#e30613") 

// Размеры и отступы
#let margin-x = 36pt // 1.27cm
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

// Логотип для титульного (большой)
#let guap-logo-large() = {
  stack(dir: ltr, spacing: 14pt,
    guap-icon-placeholder(size: 56pt),
    align(horizon, text(font: "Roboto",weight: "bold", fill: guap-dark-blue, size: 42pt)[ГУАП])
  )
}

// Логотип для слайдов (маленький)
#let guap-logo-small() = {
  image("images/guap-logo.png", width: 100pt)
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
  set text(font: "Roboto", size: 20pt, lang: "ru")

  set list(marker: [#text(fill: red)[•]])

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
    #place(top + left, dx: margin-x, dy: 62%)[
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
      place(top + right, dx: 0pt, dy: 25pt)[ // 20pt от верха страницы
         #guap-logo-small()
      ]
    },
    // Футер с номером страницы
    footer: context {
      align(right)[
        #text(size: 12pt, fill: black)[
           #counter(page).display()
        ]
      ]
    }
  )
  
  // Сбрасываем счетчик страниц, чтобы титульный был 1 (или 0, если не нумеруем)
  // Обычно титульный не нумеруется, начнем с 1 на контенте?
  // Пока оставим сквозную.
  
  body
}

// --- Функции слайдов ---

// Базовый слайд (уже есть, немного доработаем для гибкости)
#let slide(title: auto, content) = {
  page[
    // Заголовок
    #if title != auto [
       #place(top + left, dx: 0pt, dy: -65pt)[
          #block(width: 100%)[
             #text(fill: guap-blue, size: 24pt, weight: "medium", title)
             #v(-12pt)
             #line(length: 100%, stroke: (paint: guap-cyan, thickness: 1.5pt))
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

// Слайд "Текст и рисунок" (как на скриншоте 18)
// Особенность: скругление левого верхнего угла у картинки
#let slide-text-image(title: auto, text-content, image-content, caption: none) = {
  slide(title: title)[
    #grid(
      columns: (1.2fr, 1fr), // Тексту чуть больше места
      gutter: 30pt,
      [
        #text-content
      ],
      [
        // Контейнер для картинки
        #block(width: 100%, height: 350pt)[ // Фиксированная высота для примера
           #layout(size => {
              // Создаем маску или просто блок с radius
              // Typst позволяет задавать радиус для каждого угла отдельно!
              // radius: (top-left: 50pt, rest: 0pt)
              block(
                 width: 100%, 
                 height: auto, // высота по контенту или фиксированная
                 clip: true,
                 radius: (top-left: 60pt, rest: 0pt), // Скругление как на макете
                 image-content
              )
           })
        ]
        #if caption != none [
           #v(10pt)
           #text(size: 14pt, weight: "bold", fill: guap-dark-blue, caption)
        ]
      ]
    )
  ]
}

// Вспомогательные стили текста из макета
#let txt-subtitle(content) = text(fill: guap-dark-blue, style: "italic", size: 20pt, content)

