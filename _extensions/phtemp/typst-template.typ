
// This is an example typst template (based on the default template that ships
// with Quarto). It defines a typst function named 'article' which provides
// various customization options. This function is called from the 
// 'typst-show.typ' file (which maps Pandoc metadata function arguments)
//
// If you are creating or packaging a custom typst template you will likely
// want to replace this file and 'typst-show.typ' entirely. You can find 
// documentation on creating typst templates and some examples here: 
//   - https://typst.app/docs/tutorial/making-a-template/
//   - https://github.com/typst/templates


#let article(
  title: none,
  subtitle: none,
  authors: none,
  date: none,
  hero-image: none,
  abstract: none,
  abstract-title: none,
  cols: 1,
  margin: (x: 1.25in, y: 1.25in),
  paper: "us-letter",
  lang: "en",
  region: "US",
  font: (),
  fontsize: 11pt,
  sectionnumbering: none,
  toc: false,
  toc_title: none,
  toc_depth: none,
  toc_indent: 1.5em,
  doc,
) = {
 set page(
    paper: paper,
    margin: (top:3cm, bottom: 2cm, right: 2cm),
    numbering: none,
    number-align: right,
    header: (grid(columns: (1fr, 1fr),
    align(left)[#pad(left: -2.2cm, top: -0.2cm, image("images/ph-logo.png", width: 16%))],
    align(right)[#pad(right: -2cm, top: 0.5cm, image("images/nhsh-blue.png", width: 20%))])),
   background: place(right + top, rect(
      fill: rgb("#0F4985"),
      height: 2.5cm,
      width: 100%,
    )
  ))
  set par(justify: true)
  set text(lang: lang,
           region: region,
           font: font,
           size: fontsize,
           hyphenate: false)
  set heading(numbering: sectionnumbering)
  
    // Configure headings.
  show heading.where(level: 1): set block(below: 0.5cm, above: 0.5cm)
  show heading.where(level: 1): set text(rgb("#0F4985"))
  show heading.where(level: 2): set block(above: 0.5cm, below: 0.5cm)
  show heading.where(level: 3): set block(above: 0.5cm, below: 0.5cm)
  show heading.where(level: 4): set block(above: 0.5cm, below: 0.5cm)
  
  // Links should be blue.
  show link: set text(rgb("#0F4985"))
  show link: underline
  
  // Configure lists and links.
  set list(indent: 24pt, body-indent: 5pt, marker: ([•], [--]))

  if title != none {
    align(left + top)[#pad(top: 2em, bottom: 1em)[
      #text(weight: 500, size: 2em)[#title]
    ]]
  }
  
      if subtitle != none {
    align(left + top)[#pad(bottom: 2em)[#text(weight: 400, size: 1.5em, style: "normal")[#subtitle]]]
  }
  
// Hero image.
    style(styles => {
      if hero-image == none {
        return
      }

      let img = image(hero-image.path, width: 10cm)

      align(horizon + center)[#img]
    })

  if authors != none {
  
  
  
    let count = authors.len()
    let ncols = calc.min(count, 3)
    align(bottom + left)[#grid(
      columns: (1fr,) * ncols,
      row-gutter: 1.5em,
      ..authors.map(author =>
          align(left)[

            #author.name \
            #author.affiliation \
            #author.email
          ]
      )
    )]
  }
  
  
  
    

  if date != none {
   align(left + bottom)[#pad(top: 1em, bottom: 1em)[
      #text(style: "italic", weight: 100, fill: luma(0))[#date]
    ]]
  }
  
  line(
  length: 100%,
  stroke: 2pt + rgb("#0F4985"),
)

  if abstract != none {
    block(inset: 2em)[
    #text(weight: "semibold")[#abstract-title] #h(1em) #abstract
    ]
  }
  


 pagebreak()
  if toc != none {


    let title = if toc_title == none {
      auto
    } else {
      toc_title
    }
    block(above: 0em, below: 2em)[
    #show outline.entry.where(
  level: 1
): it => {
  v(11pt, weak: true)
  strong(it)
}
    #outline(
      title: toc_title,
      depth: toc_depth,
      indent: toc_indent//,
      //fill: box(width: 1fr, repeat[-])
    );
    ]
    pagebreak()
  }
  
  
  
 set page(
  footer: [
    #text(style: "italic", weight: 100, fill: luma(0))[#title]
    #h(1fr)
    #context counter(page).display()
  ]
)

 counter(page).update(1)

  if cols == 1 {
    doc
  } else {
    columns(cols, doc)
  }
}

#show table.cell.where(y: 0): strong
#show table.cell.where(x: 0): strong


#set table(
  inset: 6pt,
  stroke: none
)
