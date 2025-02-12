import 'package:flutter/material.dart';
import 'products_lists_view.dart';  
import 'autenticacion.dart'; 


class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Gris claro
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo de imagen
              Image.asset(
                'assets/logo_app_color.png',
              ),
              const SizedBox(height: 20),

              // Título de bienvenida 
              Text(
                'Bienvenid@ a Trekko',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF8A2BE2), // Lila
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                '~Descubre la magia del mundo con nosotras~',
                style: TextStyle(
                  fontSize: 16,
                  color: const Color(0xFF8A2BE2), // Lila
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Inicia sesión para continuar',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 32),

              // Campo de texto para Email
              TextField(
                controller: _emailController, // Conecta el controlador
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Correo Electrónico',
                  labelStyle: const TextStyle(color: Color(0xFF8A2BE2)), // Lila
                  prefixIcon: const Icon(Icons.email, color: Color(0xFF8A2BE2)), // Lila
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),

              // Campo de texto para Contraseña
              TextField(
                controller: _passwordController, // Conecta el controlador
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Contraseña',
                  labelStyle: const TextStyle(color: Color(0xFF8A2BE2)), // Lila
                  prefixIcon: const Icon(Icons.lock, color: Color(0xFF8A2BE2)), // Lila
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 30),

              // Botón de Inicio de Sesión
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final String email = _emailController.text; // Obtén el email del controlador
                    final String contrasena = _passwordController.text; // Obtén la contraseña del controlador

                    final bool esValido = await verificarInicioSesion(email, contrasena); // Llama a la función

                   if (esValido) {
        // Si el inicio de sesión es válido, obtenemos los datos del usuario
        final Map<String, dynamic>? usuario = await obtenerUsuarioPorEmail(email);

        if (usuario != null) {
          // Almacenar o utilizar los datos del usuario
          print('Usuario logueado: ${usuario['nombre']} - ${usuario['email']}');

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Inicio de sesión exitoso')),
          );

          // Redirige a la pantalla principal y pasa los datos del usuario
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MainLayout(usuario: usuario), // Pasa los datos del usuario
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email o contraseña incorrectos')),
        );
      }
    },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFC107), // Naranja claro
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Iniciar Sesión',
                    style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Enlace para registrarse
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '¿No tienes cuenta?',
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextButton(
                    onPressed: () {
                      // Acción para redirigir al formulario de registro
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterView()),
                      );
                    },
                    child: const Text(
                      'Regístrate aquí',
                      style: TextStyle(color: Color(0xFF8A2BE2)), // Lila
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16), // Espacio entre el Row y el texto
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.0), // Espacio lateral
                    child: Text(
                      'Al iniciar sesión o al crear una cuenta, aceptas nuestros Términos y condiciones y la Política de privacidad',
                      style: TextStyle(color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                   )
            ],
          ),
        ),
      ),
    );
  }
}



class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, introduce un correo electrónico.';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Por favor, introduce un correo válido.';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, introduce un número de teléfono.';
    }
    if (value.length != 9 || !RegExp(r'^\d+$').hasMatch(value)) {
      return 'El número debe contener 9 dígitos.';
    }
    return null;
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuario registrado con éxito')),
      );
      Navigator.pop(context); // Vuelve a la pantalla de login
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
        backgroundColor: const Color(0xFF8A2BE2), // Lila
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título
              const Text(
                'Crea una cuenta',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF8A2BE2), // Lila
                ),
              ),
              const SizedBox(height: 16),

              // Campo de texto para Nombre
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nombre Completo',
                  prefixIcon: const Icon(Icons.person, color: Color(0xFF8A2BE2)), // Lila
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce tu nombre completo.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Campo de texto para Email
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Correo Electrónico',
                  prefixIcon: const Icon(Icons.email, color: Color(0xFF8A2BE2)), // Lila
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmail,
              ),
              const SizedBox(height: 16),

              // Campo de texto para Teléfono
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Teléfono',
                  prefixIcon: const Icon(Icons.phone, color: Color(0xFF8A2BE2)), // Lila
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.phone,
                validator: _validatePhone,
              ),
              const SizedBox(height: 16),

              // Campo de texto para Contraseña
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  prefixIcon: const Icon(Icons.lock, color: Color(0xFF8A2BE2)), // Lila
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce una contraseña.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),

              // Botón para Registrarse
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFC107), // Naranja claro
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Registrarse',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Botón para Volver al inicio de sesión
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Vuelve a la pantalla de login
                  },
                  child: const Text(
                    '¿Ya tienes una cuenta? Inicia sesión',
                    style: TextStyle(color: Color(0xFF8A2BE2)), // Lila
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
