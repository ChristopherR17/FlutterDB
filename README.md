# Pixel Vault - Retro Games DB

Proyecto completo para el ejercicio de Flutter + NodeJS.

## Contenido

```txt
pixel_vault_project/
├── pixel_vault/       # App Flutter
└── server-nodejs/     # API NodeJS
```

## 1. Ejecutar servidor

```bash
cd server-nodejs
npm start
```

Servidor:

```txt
http://localhost:3000
```

## 2. Ejecutar Flutter en Chrome

En otra terminal:

```bash
cd pixel_vault
flutter pub get
flutter run -d chrome
```

## 3. Ejecutar Flutter en Android Emulator

En Android, `localhost` apunta al propio emulador, no al PC. Usa esta variable:

```bash
flutter run -d emulator-5554 --dart-define=API_URL=http://10.0.2.2:3000
```

## 4. Ejecutar Flutter en un móvil físico

Cambia la IP por la IP local de tu ordenador:

```bash
flutter run --dart-define=API_URL=http://TU_IP_LOCAL:3000
```

Ejemplo:

```bash
flutter run --dart-define=API_URL=http://192.168.1.50:3000
```

## Endpoints usados

- `POST /categories`
- `POST /games/by-category`
- `POST /games/detail`
- `POST /games/search`
- `GET /images/:filename`

## Notas

- Los datos están en `server-nodejs/data/games.js`.
- Las imágenes se sirven desde `server-nodejs/images` con llamadas GET.
- La app Flutter obtiene los datos usando llamadas POST.
