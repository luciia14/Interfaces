class User {
  final String name;
  final String email;
  final String telefono;
  final String contrasena;

  // Constructor
  User(this.name, this.email, this.contrasena, this.telefono);

  // Constructor para inicializar un usuario desde JSON
  User.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String,
        email = json['email'] as String,
        telefono = json['telefono'] as String,
        contrasena = json['contrasena'] as String;

  // Método para convertir un objeto User a JSON
  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'telefono': telefono,
        'contrasena': contrasena,
      };
}