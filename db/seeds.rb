# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Movie.create!([
  {
    title: "Iron Man",
    rating: "PG-13",
    total_gross: 318412101.00,
    description: "Tony Stark builds an armored suit to fight the throes of evil",
    released_on: "2008-05-02",
    cast: "Robert Downey Jr., Gwyneth Paltrow and Terrence Howard",
    director: "Jon Favreau",
    duration: "126 min",
    image_file_name: "ironman.jpg"
  },
  {
    title: "Superman",
    rating: "PG",
    total_gross: 134218018.00,
    description: "Clark Kent grows up to be the greatest super-hero",
    released_on: "1978-12-15",
    cast: "Christopher Reeve, Margot Kidder and Gene Hackman",
    director: "Richard Donner",
    duration: "143 min",
    image_file_name: "superman.jpg"
  },
  {
    title: "Spider-Man",
    rating: "PG-13",
    total_gross: 403706375.00,
    description: "Peter Parker gets bit by a genetically modified spider",
    released_on: "2002-05-03",
    cast: "Tobey Maguire, Kirsten Dunst and Willem Dafoe",
    director: "Sam Raimi",
    duration: "121 min",
    image_file_name: "spiderman.jpg"
  },
  {
    title: "Catwoman",
    rating: "PG-13",
    total_gross: 40200000.00,
    description: "Patience Philips has a more than respectable career as a graphic designer",
    released_on: "2004-07-23",
    cast: "Halle Berry, Sharon Stone and Benjamin Bratt",
    director: "Jean-Christophe 'Pitof' Comar",
    duration: "101 min",
    image_file_name: "catwoman.jpg"
  },
  {
    title: "Mosquito Coast",
    rating: "PG",
    total_gross: 14_302_000,
    description: "An eccentric and dogmatic inventor sells his house and takes his family to Central America to build an ice factory in the middle of the jungle.",
    released_on: "1986-11-26",
    cast: "Harrison Ford, Helen Mirren, River Phoenix, Conrad Roberts, Andre Gregory and Martha Plimpton",
    director: "Peter Weir",
    duration: "117 min",
    image_file_name: "mosquito_coast.jpg"
  },
  {
    title: "The Exterminating Angel",
    rating: "NR",
    total_gross: 4_200_000,
    description: "The guests at an upper-class soiree find themselves unable to depart.",
    released_on: "1962-08-21",
    cast: "Silvia Pinal and Enrique Rambal",
    director: "Luis Buñuel",
    duration: "94 min",
    image_file_name: "exterminating_angel.jpg"
  }
])
