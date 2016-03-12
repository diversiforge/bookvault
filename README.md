# Bookvault
Bookvault is a Rails web app for personal library management. Run it on your own server, and access it from anywhere.

Bookvault is *still very incomplete* and not ready for serious use. Schema, interface, etc. are all subject to change.

## Why?
I have more books than I can keep track of, and I enjoy used bookstores. There are a lot of library management systems out there, but none of them meet all of my criteria:
  - Accessible from my phone, for reference while in a bookstore
  - Self-hosted for control over my data
  - Simple to use and maintain

My goal with Bookvault is to create a simple, extensible interface to my library.

## Current Features
  - Book entry based on ISBN (manually entered or scanned from book's EAN barcode -- Firefox/Chrome only)
  - Automatic population of book metadata from Google Books
  - Designed with mobile use in mind

## Planned Features
  - Book entry without ISBN
  - Support for other data sources (such as the Library of Congress)
  - Book search by ISBN, title, author, ...
  - Browsing by author, category, ...
  - Lending tracking
  - User administration
  - An interface that makes more sense :)

## Install
A Linux system is assumed. In a nutshell: clone the repository and set up config/database.yml. (Currently, if you want something other than the default sqlite, you must add it to the Gemfile yourself.) Load the schema (`rake db:schema:load`), create the first admin user (`rake db:seed`), and start the server (`rails server`) or set up your webserver of choice. Once that's done, log in with username `admin` and password `admin`.