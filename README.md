kramdown-tablerize
==================

```shell
gem install kramdown-tablerize
```

A [kramdown] plugin to convert YAML to HTML tables inside Markdown, using
[Tablerize].

[kramdown]: http://kramdown.gettalong.org/
[Tablerize]: https://github.com/IFTTT/tablerize


## Usage

In Ruby...

```ruby
require 'kramdown-tablerize'

Kramdown::Document.new(content, input: 'KramdownYamlTablerize').to_html
```

...and in Markdown

```markdown
## Surveillance conducted pursuant to Titles I, III, IV and VII of FISA

--- table ---

    class: [statistics-table, nsa-surveillance-details]

    cols:
    - name: authority
    - name: num_orders
    - name: num_targets

    data:
    - class: table-header
      authority: Legal Authority
      num_orders: Annual Number of Orders
      num_targets: Estimated Number of Targets Affected
    - authority: |
                  __FISA Orders__
                  Based on probable cause
                  (Title I and III of FISA, Sections 703 and 704 of FISA)
      num_orders: "1,167 orders"
      num_targets: "1,144"
    - authority: |
                  __Section 702__
                  of FISA
      num_orders: "1 order"
      num_targets: "89,138"
    - authority: |
                  __FISA Pen Register/Trap and Trace__
                  (Title IV of FISA)
      num_orders: "131 orders"
      num_targets: "319"

--- /table ---

wow such surveillance
```


## Tips

  - In YAML, leading indent doesn't matter, so you might want to indent
    everything (as shown above) so that it renders as a code block in naive
    Markdown implementations.

  - You currently can't nest `--- table ---`…`--- /table ---` blocks
    (the parser doesn't keep track of nesting levels). However, you can nest
    tables within each other within the YAML itself:

    ```markdown
    --- table ---

        cols:
        - name: 1
        - name: 2
        data:
        - 1: cell 1,1
          2: cell 1,2
        - 1: cell 2,1
          2:
            cols:
            - name: a
            - name: b
            data:
            - a: "wow it's"
            - b: a nested table

    --- /table ---
    ```


## Wish List

  - Support using custom delimiters for the start and end of the YAML. Find a
    custom delimiter that plays nicely with kramdown and markdown, i.e. one that
    renders the best when the plugin is not enabled. It should ideally also be
    easy for text editors to target in case anyone wants to make a syntax
    highlighter for it (which should involve little more than marking off a
    region of Markdown as YAML).

  - Allow outputting to Markdown, for GitHub and other sites that don't allow
    HTML in Markdown.

  - Improve interactive error handling, including outputting on which line of
    kramdown source the error occurred. Possibly also do some pre-emptive error
    checking for less confusion down the line.

  - After the delimiters are finalized, add support to syntax-highlight YAML
    inside Markdown.


## Credit

The structure of [rfc1459/kramdown-gist] was used as a guideline for making this
library.

**kramdown-tablerize** was originally designed and written by [@szhu] at
[@IFTTT].

[rfc1459/kramdown-gist]: https://github.com/rfc1459/kramdown-gist
[@szhu]: https://github.com/szhu
[@IFTTT]: https://github.com/IFTTT
