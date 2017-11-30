# Jekyll Relations plugin

A Jekyll plugin to create relations between pages according to your file structure.

> ⚠️  
> **Note**:  
> This plugin is beta-quality and relies on the `permalink: pretty` configuration setting to work. Future versions will be compatible with other permalink settings.

## Installation

1.  Add this line to the `jekyll_plugins` group of your site's Gemfile:

    ``` ruby
    gem 'jekyll-relations', git: 'https://github.com/adamhollett/jekyll-relations'
    ```

2.  Add `jekyll-relations` under the `plugins` key in your site's `_config.yml`:

    ``` yml
    plugins:
      - jekyll-relations
    ```

    If you're using Jekyll < 3.5.0, use the `gems` key instead of `plugins`.

3.  Run `bundle` to ensure your dependencies are up to date.

## Usage

After installing this plugin, your Jekyll pages will respond to a few new methods: `parent`, `ancestors`, and `children`.

### parent

Returns a `Jekyll::Page`. You can access a page's parent in Liquid with `{{ page.parent }}`.

A page's **parent** is the next highest page in the folder structure.

- If a page's filename is `index`, then its parent is the page with the filename `index` in the folder above:

  ```
  about.md
  contact.md
  index.md     <-- {{ page.parent }}
  fruit/
    apple.md
    index.md   <-- {{ page }}
    orange.md
  ```

- If a page's filename is not `index`, then its parent is the page with the filename `index` in the same folder.

  ```
  about.md
  contact.md
  index.md     
  fruit/
    apple.md   <-- {{ page }}
    index.md   <-- {{ page.parent }}
    orange.md
  ```

### ancestors

Returns an array of `Jekyll::Page` objects. You can access a page's ancestors in Liquid with `{{ page.ancestors }}` or `{{ page.parents }}`.

A page's **ancestors** are its parent, its parent's parent, and so on until the site index. They are returned in order from highest to lowest.

It can be useful to think of a page's ancestors as the "breadcrumbs" for the page.

```
about.md
contact.md
index.md     
fruit/
  apple.md  <-- {{ page }}
  index.md
  orange.md
```

In the tree above, the page is `fruit/apple.md` and its ancestors are:

```
[
  'index.md',
  'fruit/index.md'
]
```

Because `fruit/apple.md`'s parent is `fruit/index.md` and that page's parent is `index.md`.

### children

Returns an array of `Jekyll::Page` objects. You can access a page's children in Liquid with `{{ page.children }}`.

A page's **children** are the pages directly below it in the folder structure. Only pages with the filename `index` have children.

The children of a page called `index` are the other page files in the same folder, as well as `index` files in its subfolders:

```
about.md         {{ page.children[0] }}
contact.md       {{ page.children[1] }}
index.md     <-- {{ page }}
fruit/
  apple.md
  index.md       {{ page.children[2] }}
  orange.md
```

## Testing

Run `rake test` to run tests for this plugin.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/adamhollett/jekyll-relations.
