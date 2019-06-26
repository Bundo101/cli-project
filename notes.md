1 flow
2 classes


1 User starts program
  Welcome user and introduce what app will do
    
  Present user with 3 options: movies 1-25, movies 26-50. movies 51-75
      
  Print list of those 25 with basic info: position in list, title, year released
      
  Ask user if they want more info on a movie => prompt for input
          
  if no => return to main list
  if yes => go to extra details page for that movie: position in list, title, year released, critic score, user score, sample review
            
  Ask user if they want full breakdown on movie scores from Metacritic => prompt for input
  if no => return to main list
  if yes => print new data for user: critic score + number positive, mixed & negative reviews; user score + number positive, mixed & negative reviews
  return to main list
  
2 Movie     => basic properties [position in list, title, year released]
(datastore) => extra properties [critic score, user score, sample review]
            => bonus properties [positive reviews, mixed reviews, negative reviews]
               
  CLI       => welcome user, print info and available choices for user  
(interact   => take user input, access and print data from Movie class
with user)     

  Scraper   => scrapes data from first page, assigns basic & extra properties to Movie objects
            => when requested by user scrapes second page and assigns bonus properties
  