const categories = [
  {
    id: 1,
    name: 'Arcade',
    description: 'Clásicos pensados para partidas rápidas, puntuaciones altas y recreativas.',
    icon: '🕹️'
  },
  {
    id: 2,
    name: 'Plataformas',
    description: 'Juegos de saltos, niveles y precisión que marcaron varias generaciones.',
    icon: '🍄'
  },
  {
    id: 3,
    name: 'RPG',
    description: 'Aventuras con historia, personajes, exploración y progresión.',
    icon: '⚔️'
  },
  {
    id: 4,
    name: 'Lucha',
    description: 'Combates uno contra uno con personajes memorables y combos.',
    icon: '🥊'
  },
  {
    id: 5,
    name: 'Carreras',
    description: 'Velocidad, circuitos imposibles y conducción arcade.',
    icon: '🏁'
  }
];

const games = [
  {
    id: 1,
    name: 'Pac-Man',
    category: 'Arcade',
    year: 1980,
    developer: 'Namco',
    platform: 'Arcade',
    image: 'pac_man.png',
    rating: 9.4,
    description: 'Pac-Man es uno de los iconos más reconocibles de los videojuegos. Su mecánica sencilla de comer puntos mientras se esquivan fantasmas convirtió cada partida en un reto rápido y adictivo.'
  },
  {
    id: 2,
    name: 'Space Invaders',
    category: 'Arcade',
    year: 1978,
    developer: 'Taito',
    platform: 'Arcade',
    image: 'space_invaders.png',
    rating: 9.1,
    description: 'Un shooter fijo donde el jugador debe defender la Tierra de oleadas alienígenas. Fue clave en la popularización de las máquinas recreativas.'
  },
  {
    id: 3,
    name: 'Donkey Kong',
    category: 'Arcade',
    year: 1981,
    developer: 'Nintendo',
    platform: 'Arcade',
    image: 'donkey_kong.png',
    rating: 9.0,
    description: 'Uno de los primeros grandes juegos de plataformas. Presentó a Mario, entonces conocido como Jumpman, en una misión para rescatar a Pauline.'
  },
  {
    id: 4,
    name: 'Super Mario Bros',
    category: 'Plataformas',
    year: 1985,
    developer: 'Nintendo',
    platform: 'NES',
    image: 'super_mario_bros.png',
    rating: 9.8,
    description: 'Un referente absoluto del género de plataformas. Sus mundos, secretos y diseño de niveles ayudaron a definir cómo se entendían los videojuegos de consola.'
  },
  {
    id: 5,
    name: 'Sonic the Hedgehog',
    category: 'Plataformas',
    year: 1991,
    developer: 'Sega',
    platform: 'Mega Drive',
    image: 'sonic_the_hedgehog.png',
    rating: 9.3,
    description: 'Sonic destacó por su velocidad, estilo visual colorido y música energética. Fue la gran mascota de Sega durante la era de los 16 bits.'
  },
  {
    id: 6,
    name: 'Mega Man 2',
    category: 'Plataformas',
    year: 1988,
    developer: 'Capcom',
    platform: 'NES',
    image: 'mega_man_2.png',
    rating: 9.2,
    description: 'Una secuela recordada por sus jefes, su dificultad y su banda sonora. Permite elegir el orden de los niveles y obtener armas especiales.'
  },
  {
    id: 7,
    name: 'Final Fantasy VI',
    category: 'RPG',
    year: 1994,
    developer: 'Square',
    platform: 'SNES',
    image: 'final_fantasy_vi.png',
    rating: 9.7,
    description: 'Un RPG muy valorado por su historia coral, su villano y su ambientación. Combina fantasía, tecnología y drama en una aventura extensa.'
  },
  {
    id: 8,
    name: 'Chrono Trigger',
    category: 'RPG',
    year: 1995,
    developer: 'Square',
    platform: 'SNES',
    image: 'chrono_trigger.png',
    rating: 9.8,
    description: 'Aventura de viajes temporales con combates dinámicos y múltiples finales. Es considerado uno de los RPG más completos de la época.'
  },
  {
    id: 9,
    name: 'Pokémon Red',
    category: 'RPG',
    year: 1996,
    developer: 'Game Freak',
    platform: 'Game Boy',
    image: 'pokemon_red.png',
    rating: 9.5,
    description: 'El inicio de una de las sagas más famosas del mundo. Su fórmula de capturar, entrenar e intercambiar criaturas se volvió un fenómeno global.'
  },
  {
    id: 10,
    name: 'Street Fighter II',
    category: 'Lucha',
    year: 1991,
    developer: 'Capcom',
    platform: 'Arcade / SNES',
    image: 'street_fighter_ii.png',
    rating: 9.6,
    description: 'El juego que consolidó el género de lucha moderna. Sus personajes, movimientos especiales y enfrentamientos competitivos son legendarios.'
  },
  {
    id: 11,
    name: 'Mortal Kombat',
    category: 'Lucha',
    year: 1992,
    developer: 'Midway',
    platform: 'Arcade',
    image: 'mortal_kombat.png',
    rating: 8.9,
    description: 'Famoso por su estilo digitalizado, violencia exagerada y fatalities. Se convirtió rápidamente en una saga muy reconocible.'
  },
  {
    id: 12,
    name: 'Tekken 3',
    category: 'Lucha',
    year: 1997,
    developer: 'Namco',
    platform: 'PlayStation',
    image: 'tekken_3.png',
    rating: 9.4,
    description: 'Uno de los juegos de lucha 3D más recordados de PlayStation. Destacó por su plantilla de personajes y su jugabilidad fluida.'
  },
  {
    id: 13,
    name: 'Out Run',
    category: 'Carreras',
    year: 1986,
    developer: 'Sega',
    platform: 'Arcade',
    image: 'out_run.png',
    rating: 9.1,
    description: 'Un clásico de conducción arcade con rutas alternativas, música memorable y una sensación de velocidad muy avanzada para su época.'
  },
  {
    id: 14,
    name: 'F-Zero',
    category: 'Carreras',
    year: 1990,
    developer: 'Nintendo',
    platform: 'SNES',
    image: 'f_zero.png',
    rating: 9.0,
    description: 'Juego futurista de carreras que aprovechó el modo gráfico de SNES para crear circuitos rápidos y una estética muy particular.'
  },
  {
    id: 15,
    name: 'Mario Kart 64',
    category: 'Carreras',
    year: 1996,
    developer: 'Nintendo',
    platform: 'Nintendo 64',
    image: 'mario_kart_64.png',
    rating: 9.2,
    description: 'Carreras multijugador con objetos, derrapes y circuitos memorables. Fue uno de los grandes juegos sociales de Nintendo 64.'
  }
];

module.exports = { categories, games };
