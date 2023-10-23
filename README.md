# Just Play Test

## _Realizada por Alejandro Muñoz_

Prueba realizada con:

- Patron bloc
- Patrones solid
- Inyeccion de dependencias
- Dart define para variables de entorno
- Login con Google mediante Firebase
- Api de ciudades

### Metodo de compilación

- Crear archivo a nivel raiz llamado api-key.json y agregar las credenciales enviadas por correo

- Revisar que en Vscode el archivo _launch.json_ este asi:

```bash
 {
   "name": "just_play_test",
   "request": "launch",
   "type": "dart",
   "args": ["--dart-define-from-file","api-key.json"] //add this line
 },
```

- Luego podran compilar normalmente con F5

[Video demostrativo](https://youtube.com/shorts/wd0f9aKvhaY)
