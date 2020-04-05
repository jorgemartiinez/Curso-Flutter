/* Clase modelo peliculas que tendrá una lista de películas */
class Peliculas {
  List<Pelicula> items = new List();

  Peliculas();

  // Recibimos la respuesta en formato json entera (este modelo sería como "results" en la API)
  // Con este constructor generaremos la lista de películas en base a la respuesta que recibimos
  Peliculas.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    // Recorremos el jsonList recibido y creamos objetos de las películas
    for (var item in jsonList) {
      final pelicula = new Pelicula.fromJsonMap(item);
      items.add(pelicula);
    }
  }
}

/* Clase modelo Película que servirá para crear los objetos de tipo película que vienen de la API */
class Pelicula {

  // id unico para el hero animation, lo setearemos al tagear por primera vez el hero animation, y en moviedetail accederemos al tag mediante esta propiedad uniqueID
  String uniqueId;

  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;

  // Constructor principal con nombre
  Pelicula({
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.id,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });

  // Creamos un segundo constructor que servirá para crear una instancia de Película en base a un json
  Pelicula.fromJsonMap(Map<String, dynamic> json) {
    // Map se tratará como un objeto con sus claves string y el valor que podrá ser dynamic
    // hay que tener en cuenta que en el json los nombres vienen separados por _ y aquí usamos camelCase

    this.popularity = json['popularity'] / 1;
    this.voteCount = json['vote_count'];
    this.video = json['video'];
    this.posterPath = json['poster_path'];
    this.id = json['id'];
    this.adult = json['adult'];
    this.backdropPath = json['backdrop_path'];
    this.originalLanguage = json['original_language'];
    this.originalTitle = json['original_title'];
    this.genreIds = json['genre_ids'].cast<int>();
    this.title = json['title'];
    this.voteAverage =
        json['vote_average'] / 1; // lo convertimos siempre a double
    this.overview = json['overview'];
    this.releaseDate = json['release_date'];
  }

  getPosterImg() {
    if (this.posterPath == null) {
      return 'https://www.galvanizadosizurza.com/wp-content/themes/consultix/images/no-image-found-360x250.png';
    }
    return 'https://image.tmdb.org/t/p/w500/${this.posterPath}';
  }

  getBackgroundImg(){
   if (this.backdropPath == null) {
      return 'https://www.galvanizadosizurza.com/wp-content/themes/consultix/images/no-image-found-360x250.png';
    }
    return 'https://image.tmdb.org/t/p/w500/${this.backdropPath}';
  }
}
