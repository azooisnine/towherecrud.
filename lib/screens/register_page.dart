import 'package:flutter/material.dart';
import '../auth/login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();

  bool isLoading = false;
  bool rememberMe = false;

  Future<void> register() async {
    final email = emailController.text.trim();
    final pass = passController.text.trim();
    final confirm = confirmPassController.text.trim();

    if (email.isEmpty || pass.isEmpty || confirm.isEmpty) {
      _show("Semua field harus diisi");
      return;
    }

    if (pass != confirm) {
      _show("Password tidak sama");
      return;
    }

    setState(() => isLoading = true);

    final result = await AuthService.register(
      email: email,
      password: pass,
    );

    setState(() => isLoading = false);

    if (result == null) {
      _show("Register berhasil");
      Navigator.pop(context);
    } else {
      _show(_error(result));
    }
  }

  String _error(String code) {
    switch (code) {
      case 'email-already-in-use':
        return "Email sudah digunakan";
      case 'weak-password':
        return "Password terlalu lemah";
      case 'invalid-email':
        return "Email tidak valid";
      default:
        return "Terjadi kesalahan";
    }
  }

  void _show(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  @override
  Widget build(BuildContext context) {
    const bgColor = Color(0xFFF4EEDF);
    const tealColor = Color(0xFF009999);
    const yellowColor = Color(0xFFF7D46B);
    const orangeColor = Color(0xFFF5B04C);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bgColor,
      body: Stack(
        children: [
          /// WAVES
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 260,
              child: Stack(
                children: [
                  // ORANGE
                  Positioned.fill(
                    child: ClipPath(
                      clipper: WaveClipper1(),
                      child: Container(
                        color: orangeColor,
                      ),
                    ),
                  ),

                  // YELLOW
                  Positioned.fill(
                    top: 25,
                    child: ClipPath(
                      clipper: WaveClipper2(),
                      child: Container(
                        color: yellowColor,
                      ),
                    ),
                  ),

                  // TEAL
                  Positioned.fill(
                    top: 50,
                    child: ClipPath(
                      clipper: WaveClipper3(),
                      child: Container(
                        color: tealColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SafeArea(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: [
                    const SizedBox(height: 95),

                    /// ICON
                    Transform.rotate(
                      angle: -0.8,
                      child: Icon(
                        Icons.confirmation_number,
                        size: 58,
                        color: yellowColor,
                      ),
                    ),

                    const SizedBox(height: 18),

                    /// TITLE
                    const Text(
                      "SIGN UP",
                      style: TextStyle(
                        color: tealColor,
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 55),

                    /// USERNAME
                    _buildField(
                      controller: emailController,
                      hint: "Username",
                      icon: Icons.person,
                    ),

                    const SizedBox(height: 14),

                    /// PASSWORD
                    _buildField(
                      controller: passController,
                      hint: "Password",
                      icon: Icons.key,
                      obscure: true,
                    ),

                    const SizedBox(height: 14),

                    /// CONFIRM PASSWORD
                    _buildField(
                      controller: confirmPassController,
                      hint: "Confirm Password",
                      icon: Icons.remove_red_eye,
                      obscure: true,
                    ),

                    const SizedBox(height: 16),

                    /// REMEMBER ME
                    Row(
                      children: [
                        SizedBox(
                          width: 18,
                          height: 18,
                          child: Checkbox(
                            value: rememberMe,
                            activeColor: tealColor,
                            side: const BorderSide(
                              color: tealColor,
                              width: 1.2,
                            ),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            onChanged: (value) {
                              setState(() {
                                rememberMe = value!;
                              });
                            },
                          ),
                        ),

                        const SizedBox(width: 8),

                        const Text(
                          "Remember Me",
                          style: TextStyle(
                            color: tealColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    /// BUTTON
                    SizedBox(
                      width: 210,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : register,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: tealColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "SIGN UP",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// SIGN UP
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Aready have an account? ",
                          style: TextStyle(
                            color: tealColor.withOpacity(0.8),
                            fontSize: 13,
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const RegisterPage(),
                              ),
                            );
                          },
                          child: const Text(
                            "Log In",
                            style: TextStyle(
                              color: tealColor,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscure = false,
  }) {
    const tealColor = Color(0xFF009999);

    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.75),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: const TextStyle(
          color: tealColor,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: TextStyle(
            color: tealColor,
            fontSize: 16,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 15,
          ),
          suffixIcon: Icon(
            icon,
            color: tealColor,
            size: 22,
          ),
        ),
      ),
    );
  }
}

class WaveClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height * 0.45);

    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.25,
      size.width * 0.5,
      size.height * 0.42,
    );

    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.60,
      size.width,
      size.height * 0.30,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class WaveClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height * 0.50);

    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.30,
      size.width * 0.5,
      size.height * 0.47,
    );

    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.65,
      size.width,
      size.height * 0.35,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class WaveClipper3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height * 0.55);

    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.35,
      size.width * 0.5,
      size.height * 0.52,
    );

    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.72,
      size.width,
      size.height * 0.40,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}