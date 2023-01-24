# Changelog

## [2.1.0](https://github.com/smjonas/duplicate.nvim/compare/v2.0.0...v2.1.0) (2023-01-24)


### Features

* move cursor to beginning of duplicated text ([06e5e46](https://github.com/smjonas/duplicate.nvim/commit/06e5e46da00925c409ee6bdb6cd0a15a5dac32f5))
* respect v:count in line-wise mapping ([a3691db](https://github.com/smjonas/duplicate.nvim/commit/a3691db9e58b8f1c4b0b9ed76098246299dee913))


### Bug Fixes

* moving cursor when duplicating current line ([#10](https://github.com/smjonas/duplicate.nvim/issues/10)) ([d58104c](https://github.com/smjonas/duplicate.nvim/commit/d58104c362ceb886c5e6677c43c011bd2b1e788f))

## [2.0.0](https://github.com/smjonas/duplicate.nvim/compare/v1.0.0...v2.0.0) (2023-01-21)


### ⚠ BREAKING CHANGES

* change configuration for operators

### Features

* add config.transform to support modification of selection before pasting ([866bcb5](https://github.com/smjonas/duplicate.nvim/commit/866bcb5e89aac351a69a034a801f81d170de93c3))


### Code Refactoring

* change configuration for operators ([c25c9b4](https://github.com/smjonas/duplicate.nvim/commit/c25c9b4b7f1b591ba1649b36a8e48a0b9e50d5e6))

## 1.0.0 (2023-01-21)


### Features

* add separate visual_mode textobject, disabled by default ([6d73f6a](https://github.com/smjonas/duplicate.nvim/commit/6d73f6a17eab03267158a76950d9177f84221ca0))
* add ydd mapping to duplicate current line ([08ed0ba](https://github.com/smjonas/duplicate.nvim/commit/08ed0ba603af27d770a8048822cd7d9e0f417090))
* basic duplication within a line ([f085344](https://github.com/smjonas/duplicate.nvim/commit/f085344dda0b06f71bfd4b2ff6bb6c27179ac685))
