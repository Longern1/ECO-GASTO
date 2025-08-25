import 'package:flutter/material.dart';

// Tamaño del FAB (logo) y margen extra del notch
const double kFabSize = 64;
const double kNotchExtra = 16;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eco Gasto',
      debugShowCheckedModeBanner: false,
      // En MaterialApp (rutas)
      routes: {
        '/': (_) => const InicioScreen(),
        '/login': (_) => const LoginScreen(),
        '/register': (_) => const RegisterScreen(),
        '/dashboard': (_) => const DashboardScreen(),
        '/balance': (_) => const BalanceDetailScreen(),
        '/gastos': (_) => const GastosDetailScreen(),
        '/ahorros': (_) => const AhorrosDetailScreen(),
        '/ingresos': (context) => const IngresosDetailScreen(),
        '/categorias': (context) => const CategoriasScreen(),
        '/reportes': (context) => const ReportesScreen(),
        '/calendario': (context) => const CalendarioScreen(),
        '/notifs': (context) => const NotifsScreen(),
      },
      initialRoute: '/',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF27AE60)),
        useMaterial3: true,
      ),
    );
  }
}

/// --------- 2) INICIO (logo + dos botones bonitos) ----------
class InicioScreen extends StatelessWidget {
  const InicioScreen({super.key});

  static const Color ecoGreen = Color(0xFF27AE60);
  static const Color ecoGreenDark = Color(0xFF1F8A4F);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final w = size.width;

    return Scaffold(
      body: Stack(
        children: [
          // --- Fondo con degradado ---
          const _GradientBackground(),

          // --- Burbujas decorativas (opcionales) ---
          const _Bubbles(),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 520),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 12),

                      // --- Tarjeta del logo ---
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 18,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: SizedBox(
                          width: w * 0.45,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Image.asset(
                              'assets/images/logo_ecogasto.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // --- Título & subtítulo ---
                      Text(
                        'Eco Gasto',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF0F0F0F),
                              letterSpacing: .2,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Organiza tu dinero de forma simple y sostenible.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.black.withOpacity(.65),
                        ),
                      ),

                      const SizedBox(height: 36),

                      // --- Botón Registrarse (primario) ---
                      _PrimaryButton(
                        text: 'Registrarse',
                        onPressed: () =>
                            Navigator.pushNamed(context, '/register'),
                      ),

                      const SizedBox(height: 14),

                      // --- Botón Iniciar sesión (secundario) ---
                      _SecondaryButton(
                        text: 'Iniciar sesión',
                        onPressed: () => Navigator.pushNamed(context, '/login'),
                      ),

                      const SizedBox(height: 24),

                      // --- Texto legal / pie ---
                      Opacity(
                        opacity: .75,
                        child: Text(
                          'Al continuar aceptas nuestros Términos y Política de privacidad.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GradientBackground extends StatelessWidget {
  const _GradientBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0, -1),
          end: Alignment(0, 1),
          colors: [
            Color(0xFFEFF8F2), // verde muy claro arriba
            Color(0xFFF9FBFC), // casi blanco al centro
            Color(0xFFFFFFFF), // blanco abajo
          ],
        ),
      ),
    );
  }
}

class _Bubbles extends StatelessWidget {
  const _Bubbles();

  @override
  Widget build(BuildContext context) {
    final green = const Color(0xFF27AE60).withOpacity(.10);
    final dark = const Color(0xFF1F8A4F).withOpacity(.10);

    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            top: -60,
            left: -40,
            child: _Circle(color: green, size: 160),
          ),
          Positioned(
            top: 120,
            right: -50,
            child: _Circle(color: dark, size: 120),
          ),
          Positioned(
            bottom: -70,
            left: 30,
            child: _Circle(color: green, size: 200),
          ),
        ],
      ),
    );
  }
}

class _Circle extends StatelessWidget {
  const _Circle({required this.color, required this.size});
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        // blur sutil
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(.35),
            blurRadius: 30,
            spreadRadius: 2,
          ),
        ],
      ),
    );
  }
}

/// --------- Botón primario (relleno) ----------
class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({required this.text, required this.onPressed});
  final String text;
  final VoidCallback onPressed;

  static const Color ecoGreen = Color(0xFF27AE60);
  static const Color ecoGreenDark = Color(0xFF1F8A4F);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        style:
            ElevatedButton.styleFrom(
              backgroundColor: ecoGreen,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ).copyWith(
              overlayColor: WidgetStatePropertyAll(
                ecoGreenDark.withOpacity(.12),
              ),
            ),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}

/// --------- Botón secundario (bordeado) ----------
class _SecondaryButton extends StatelessWidget {
  const _SecondaryButton({required this.text, required this.onPressed});
  final String text;
  final VoidCallback onPressed;

  static const Color ecoGreen = Color(0xFF27AE60);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: ecoGreen, width: 2),
          foregroundColor: ecoGreen,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}

// ===== PALETA Y ESTILOS =====
const _ecoGreen = Color(0xFF27AE60);
const _ecoGreenDark = Color(0xFF1F8A4F);
const _titleColor = Color(0xFF2F3A46);
const _labelColor = Color(0xFF2F3A46);

final _fill = Colors.grey[200];

TextStyle get _titleStyle => const TextStyle(
  color: _titleColor,
  fontSize: 28,
  fontWeight: FontWeight.w900,
  letterSpacing: .2,
);

ButtonStyle get _pillButton =>
    ElevatedButton.styleFrom(
      backgroundColor: _ecoGreen,
      foregroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
    ).copyWith(
      overlayColor: WidgetStatePropertyAll(_ecoGreenDark.withOpacity(.12)),
    );

// ===== WIDGET: encabezado con degradado y onda =====
class _Header extends StatelessWidget {
  const _Header({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Stack(
        fit: StackFit.expand,
        children: [
          const _HeaderGradient(),
          Positioned.fill(
            child: CustomPaint(
              painter: _WavePainter(color: Colors.white.withOpacity(.15)),
            ),
          ),
          SafeArea(
            child: Center(child: Text(title, style: _titleStyle)),
          ),
          Positioned(
            left: 8,
            top: MediaQuery.of(context).padding.top + 4,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () => Navigator.pop(context),
              style: IconButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(.18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderGradient extends StatelessWidget {
  const _HeaderGradient();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF3AD06F), _ecoGreen],
        ),
      ),
    );
  }
}

class _WavePainter extends CustomPainter {
  const _WavePainter({required this.color});
  final Color color;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path()
      ..moveTo(0, size.height * .75)
      ..quadraticBezierTo(
        size.width * .25,
        size.height * .65,
        size.width * .5,
        size.height * .78,
      )
      ..quadraticBezierTo(
        size.width * .75,
        size.height * .91,
        size.width,
        size.height * .82,
      )
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// ===== WIDGET: tarjeta contenedora =====
class _CardContainer extends StatelessWidget {
  const _CardContainer({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.06),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }
}

// ===== WIDGET: label + textfield con icono =====
class _LabeledIconField extends StatefulWidget {
  const _LabeledIconField({
    required this.label,
    required this.hint,
    required this.icon,
    this.keyboardType,
    this.isPassword = false,
  });
  final String label;
  final String hint;
  final IconData icon;
  final TextInputType? keyboardType;
  final bool isPassword;

  @override
  State<_LabeledIconField> createState() => _LabeledIconFieldState();
}

class _LabeledIconFieldState extends State<_LabeledIconField> {
  bool _obscure = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            color: _labelColor,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          obscureText: widget.isPassword ? _obscure : false,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            prefixIcon: Icon(widget.icon, color: Colors.grey[700]),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscure ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  )
                : null,
            hintText: widget.hint,
            filled: true,
            fillColor: _fill,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}

// ===================== LOGIN BONITO =====================
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      body: Column(
        children: [
          const _Header(title: 'Iniciar sesión'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 16, bottom: 24),
              child: Column(
                children: [
                  _CardContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const _LabeledIconField(
                          label: 'Correo',
                          hint: 'tucorreo@dominio.com',
                          icon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16),
                        const _LabeledIconField(
                          label: 'Contraseña',
                          hint: '••••••••',
                          icon: Icons.lock_outline,
                          isPassword: true,
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text('¿Olvidaste tu contraseña?'),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 56,
                          child: ElevatedButton(
                            style: _pillButton,
                            onPressed: () => Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/dashboard',
                              (r) => false,
                            ),
                            child: const Text('Iniciar sesión'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () =>
                        Navigator.pushReplacementNamed(context, '/register'),
                    child: const Text('¿No tienes cuenta? Regístrate'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ===================== REGISTRO BONITO =====================
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FB),
      body: Column(
        children: [
          const _Header(title: 'Registrarse'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 16, bottom: 24),
              child: Column(
                children: [
                  _CardContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: const [
                        _LabeledIconField(
                          label: 'Nombre',
                          hint: 'Tu nombre',
                          icon: Icons.person_outline,
                        ),
                        SizedBox(height: 16),
                        _LabeledIconField(
                          label: 'Apellido',
                          hint: 'Tu apellido',
                          icon: Icons.badge_outlined,
                        ),
                        SizedBox(height: 16),
                        _LabeledIconField(
                          label: 'Cédula',
                          hint: 'Documento de identidad',
                          icon: Icons.credit_card_outlined,
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 16),
                        _LabeledIconField(
                          label: 'Correo',
                          hint: 'tucorreo@dominio.com',
                          icon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 16),
                        _LabeledIconField(
                          label: 'Contraseña',
                          hint: 'Crea una contraseña',
                          icon: Icons.lock_outline,
                          isPassword: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      height: 56,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: _pillButton,
                        onPressed: () => Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/dashboard',
                          (r) => false,
                        ),
                        child: const Text('Registrarse'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// --------- DASHBOARD ejemplo ----------

/// ============== PALETA / HELPERS ==============
class AppColors {
  static const ecoGreen = Color(0xFF27AE60);
  static const ecoGreenDark = Color(0xFF1F8A4F);
  static const bgSoft = Color(0xFFF1FAF1);
  static const textStrong = Color(0xFF1E293B);
  static const ok = Color(0xFF2E7D32);
  static const danger = Color(0xFFE53935);
}

String _fmtInt(num v) => v
    .toStringAsFixed(0)
    .replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => ',');

String _money(double v, {bool showSign = true}) {
  final sign = v < 0 ? '-' : '+';
  final abs = v.abs().toStringAsFixed(2);
  return showSign ? '$sign\$$abs' : '\$$abs';
}

/// ============== DASHBOARD ==============
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _unread = 3; // contador inicial

  void _snack(BuildContext ctx, String msg) =>
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(msg)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgSoft,

      // ---------- APP BAR ----------
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        titleSpacing: 0,
        title: Row(
          children: [
            const SizedBox(width: 12),
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: AppColors.ecoGreen,
                borderRadius: BorderRadius.circular(6),
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.attach_money,
                size: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'EcoGasto',
                  style: TextStyle(
                    color: AppColors.textStrong,
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Control de Gastos Personales',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                onPressed: () async {
                  await Navigator.pushNamed(context, '/notifs');
                  if (!mounted) return;
                  setState(() => _unread = 0); // limpia badge al regresar
                },
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: AppColors.textStrong,
                ),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Visibility(
                  visible: _unread > 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '$_unread',
                      style: const TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),

      // ---------- CUERPO ----------
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            14,
            14,
            14,
            110,
          ), // espacio para la barra inferior
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Métricas
              LayoutBuilder(
                builder: (context, c) {
                  final isNarrow = c.maxWidth < 760;
                  final cards = [
                    _StatCard(
                      title: 'Balance Total',
                      value: '\$12,450.00',
                      sub: '↗ +2.5% desde el mes pasado',
                      subColor: AppColors.ok,
                      icon: Icons.account_balance_wallet_outlined,
                      onTap: () => Navigator.pushNamed(context, '/balance'),
                    ),
                    _StatCard(
                      title: 'Gastos del Mes',
                      value: '\$3,240.00',
                      sub: '↗ +8.2% vs mes anterior',
                      subColor: AppColors.danger,
                      icon: Icons.credit_card_outlined,
                      onTap: () => Navigator.pushNamed(context, '/gastos'),
                    ),
                    _StatCard(
                      title: 'Ahorros',
                      value: '\$8,750.00',
                      sub: '↗ Meta: 70% completada',
                      subColor: AppColors.ecoGreenDark,
                      icon: Icons.workspace_premium_outlined,
                      onTap: () => Navigator.pushNamed(context, '/ahorros'),
                    ),
                  ];

                  return isNarrow
                      ? Column(
                          children: [
                            for (final w in cards) ...[
                              w,
                              const SizedBox(height: 12),
                            ],
                          ],
                        )
                      : Row(
                          children: [
                            Expanded(child: cards[0]),
                            const SizedBox(width: 12),
                            Expanded(child: cards[1]),
                            const SizedBox(width: 12),
                            Expanded(child: cards[2]),
                          ],
                        );
                },
              ),
              const SizedBox(height: 16),

              // Presupuesto
              const _Card(child: _BudgetSection(spent: 3240, goal: 5000)),
              const SizedBox(height: 16),

              // Transacciones
              const _Card(child: _RecentTransactions()),
              const SizedBox(height: 16),

              // Alertas / Recordatorios
              const _Card(child: _AlertsSection()),
            ],
          ),
        ),
      ),

      // ---------- FAB central con logo ----------
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _LogoFab(
        onTap: () => Navigator.pushNamedAndRemoveUntil(
          context,
          '/dashboard',
          (r) => false,
        ),
      ),

      // ---------- Barra inferior (Acciones rápidas) ----------
      bottomNavigationBar: _BottomActionsBar(
        left: const [
          _Action(icon: Icons.add, label: 'Gasto'),
          _Action(icon: Icons.show_chart_outlined, label: 'Ingreso'),
          _Action(icon: Icons.local_offer_outlined, label: 'Categorías'),
        ],
        right: const [
          _Action(icon: Icons.bar_chart_outlined, label: 'Reportes'),
          _Action(icon: Icons.calendar_today_outlined, label: 'Calendario'),
          _Action(icon: Icons.notifications_none, label: 'Notifs'),
        ],
        onPressed: (label) {
          switch (label) {
            case 'Gasto':
              Navigator.pushNamed(context, '/gastos');
              break;
            case 'Ingreso':
              Navigator.pushNamed(context, '/balance');
              break;
            case 'Categorías':
              Navigator.pushNamed(context, '/categorias');
              break;
            case 'Reportes':
              Navigator.pushNamed(context, '/reportes');
              break;
            case 'Calendario':
              Navigator.pushNamed(context, '/calendario');
              break;
            case 'Notifs':
              Navigator.pushNamed(context, '/notifs');
              break;
            default:
              _snack(context, 'Ruta no definida: $label');
          }
        },
      ),
    );
  }
}

/// ============== COMPONENTES ==============
class _Card extends StatelessWidget {
  const _Card({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.title,
    required this.value,
    required this.sub,
    required this.subColor,
    required this.icon,
    this.onTap,
  });

  final String title, value, sub;
  final Color subColor;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.05),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Icon(icon, size: 16, color: Colors.black54),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        value,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: AppColors.textStrong,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        sub,
                        style: TextStyle(color: subColor, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BudgetSection extends StatelessWidget {
  const _BudgetSection({required this.spent, required this.goal});
  final double spent, goal;

  @override
  Widget build(BuildContext context) {
    final double pct = (goal == 0 ? 0.0 : (spent / goal)).clamp(0.0, 1.0);
    final double remaining = (goal - spent).clamp(0.0, goal);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Presupuesto Mensual',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: AppColors.textStrong,
          ),
        ),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Gastado'),
            Text(
              '\$${_fmtInt(spent)} / \$${_fmtInt(goal)}',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: SizedBox(
            height: 12,
            child: Stack(
              children: [
                Container(color: Colors.grey.shade300),
                FractionallySizedBox(
                  widthFactor: pct, // double ✔️
                  child: Container(color: AppColors.ecoGreen),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${(pct * 100).toStringAsFixed(1)}% utilizado',
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
            Text(
              '\$${_fmtInt(remaining)} restante',
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ],
        ),
      ],
    );
  }
}

class _AlertsSection extends StatelessWidget {
  const _AlertsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Alertas y Recordatorios',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: AppColors.textStrong,
          ),
        ),
        SizedBox(height: 14),
        _AlertTile(
          icon: Icons.error_outline,
          title: 'Presupuesto casi agotado',
          subtitle: 'Has gastado el 64.8% de tu presupuesto mensual',
          bg: Color(0xFFFFEFEF),
          border: Color(0xFFF5B9B9),
          iconColor: Colors.redAccent,
        ),
        SizedBox(height: 10),
        _AlertTile(
          icon: Icons.event_available_outlined,
          title: 'Pago pendiente',
          subtitle: 'Tarjeta de crédito vence en 3 días - \$450.00',
          bg: Color(0xFFFFFDEB),
          border: Color(0xFFEFE7AE),
          iconColor: Color(0xFFB59B0A),
        ),
        SizedBox(height: 10),
        _AlertTile(
          icon: Icons.savings_outlined,
          title: 'Meta de ahorro',
          subtitle: '¡Estás cerca de tu meta mensual! Solo faltan \$250',
          bg: Color(0xFFEFF6EF),
          border: Color(0xFFCADDCB),
          iconColor: AppColors.ecoGreen,
        ),
      ],
    );
  }
}

class _AlertTile extends StatelessWidget {
  const _AlertTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.bg,
    required this.border,
    required this.iconColor,
  });
  final IconData icon;
  final String title, subtitle;
  final Color bg, border, iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: border),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: AppColors.textStrong,
                  ),
                ),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: Colors.black87)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RecentTransactions extends StatelessWidget {
  const _RecentTransactions();

  @override
  Widget build(BuildContext context) {
    final items = <_TxItem>[
      _TxItem(
        'Supermercado',
        'Hoy',
        -85.50,
        'Alimentación',
        const Color(0xFFB4C020),
      ),
      _TxItem('Salario', 'Ayer', 2500.00, 'Trabajo', const Color(0xFFB4C020)),
      _TxItem(
        'Gasolina',
        '2 días',
        -45.00,
        'Transporte',
        const Color(0xFFB4C020),
      ),
      _TxItem(
        'Netflix',
        '3 días',
        -12.99,
        'Entretenimiento',
        const Color(0xFFB4C020),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Transacciones Recientes',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: AppColors.textStrong,
          ),
        ),
        const SizedBox(height: 14),
        for (final tx in items) ...[
          _TxTile(tx: tx),
          const SizedBox(height: 10),
        ],
      ],
    );
  }
}

class _TxItem {
  _TxItem(this.title, this.subtitle, this.amount, this.tag, this.tagColor);
  final String title, subtitle, tag;
  final double amount;
  final Color tagColor;
}

class _TxTile extends StatelessWidget {
  const _TxTile({required this.tx});
  final _TxItem tx;

  @override
  Widget build(BuildContext context) {
    final isNeg = tx.amount < 0;
    final amountStyle = TextStyle(
      color: isNeg ? AppColors.danger : AppColors.ok,
      fontWeight: FontWeight.w800,
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.ecoGreen,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      tx.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: AppColors.textStrong,
                      ),
                    ),
                    const SizedBox(width: 8),
                    _Chip(text: tx.tag, color: tx.tagColor),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  tx.subtitle,
                  style: const TextStyle(color: Colors.black54, fontSize: 12),
                ),
              ],
            ),
          ),
          Text(_money(tx.amount), style: amountStyle),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.text, required this.color});
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final bg = color.withOpacity(.25);
    final hsl = HSLColor.fromColor(color);
    final fg = hsl
        .withLightness((hsl.lightness - .35).clamp(0.0, 1.0))
        .toColor();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: TextStyle(color: fg, fontSize: 11, fontWeight: FontWeight.w700),
      ),
    );
  }
}

/// ============== BOTTOM BAR / FAB ==============
class _Action {
  const _Action({required this.icon, required this.label});
  final IconData icon;
  final String label;
}

class _LogoFab extends StatelessWidget {
  const _LogoFab({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: kFabSize,
      height: kFabSize,
      child: FloatingActionButton(
        elevation: 3,
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
        onPressed: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Image.asset(
            'assets/images/logo_ecogasto.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

class _BottomActionsBar extends StatelessWidget {
  const _BottomActionsBar({
    super.key,
    required this.left,
    required this.right,
    required this.onPressed,
  });

  final List<_Action> left;
  final List<_Action> right;
  final void Function(String label) onPressed;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: Colors.white,
      elevation: 14,
      padding: EdgeInsets.zero,
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 80,
          child: LayoutBuilder(
            builder: (context, c) {
              final double centerGap = kFabSize + kNotchExtra;

              Widget side(List<_Action> items) => Row(
                children: items
                    .map(
                      (a) => Expanded(
                        child: _BottomItem(a: a, onPressed: onPressed),
                      ),
                    )
                    .toList(),
              );

              return Row(
                children: [
                  Expanded(child: side(left)),
                  SizedBox(width: centerGap), // hueco real del notch
                  Expanded(child: side(right)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _BottomItem extends StatelessWidget {
  const _BottomItem({required this.a, required this.onPressed});
  final _Action a;
  final void Function(String) onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => onPressed(a.label),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(a.icon, size: 22, color: Colors.black87),
            const SizedBox(height: 4),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                a.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// -------- BALANCE DETAIL SCREEN --------
// ================== BALANCE DETAIL SCREEN (CORREGIDO) ==================
class BalanceDetailScreen extends StatelessWidget {
  const BalanceDetailScreen({super.key});

  void _snack(BuildContext ctx, String msg) =>
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(msg)));

  // ---- BottomSheet para registrar ingreso ----
  Future<void> _openAddIncomeSheet(BuildContext context) async {
    final amountCtrl = TextEditingController();
    final descCtrl = TextEditingController(text: 'Ingreso');
    String destino = 'Efectivo'; // valor por defecto

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
          ),
          child: StatefulBuilder(
            builder: (ctx, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.trending_up_outlined,
                        color: AppColors.ecoGreen,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Registrar ingreso',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: AppColors.textStrong,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: amountCtrl,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Monto',
                      prefixText: '\$ ',
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: descCtrl,
                    decoration: InputDecoration(
                      labelText: 'Descripción',
                      hintText: 'Salario, transferencia, intereses…',
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Destino',
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: destino,
                        items: const [
                          DropdownMenuItem(
                            value: 'Efectivo',
                            child: Text('Efectivo'),
                          ),
                          DropdownMenuItem(
                            value: 'Cuenta Corriente',
                            child: Text('Cuenta Corriente'),
                          ),
                          DropdownMenuItem(
                            value: 'Caja de Ahorro',
                            child: Text('Caja de Ahorro'),
                          ),
                        ],
                        onChanged: (v) =>
                            setState(() => destino = v ?? 'Efectivo'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(ctx),
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Cancelar'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.check),
                          label: const Text('Guardar'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.ecoGreen,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            final v =
                                double.tryParse(
                                  amountCtrl.text.replaceAll(',', '.'),
                                ) ??
                                0.0;
                            if (v <= 0) {
                              ScaffoldMessenger.of(ctx).showSnackBar(
                                const SnackBar(
                                  content: Text('Ingresa un monto válido'),
                                ),
                              );
                              return;
                            }
                            Navigator.pop(ctx);
                            _snack(
                              context,
                              'Ingreso agregado: \$${v.toStringAsFixed(2)} → $destino',
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // --- Datos mock (alineados con tu dashboard) ---
    final efectivo = 2350.00;
    final cuentas = [
      ('Cuenta Corriente', 6200.00),
      ('Caja de Ahorro', 4700.00),
    ];
    final tarjetas = [('Tarjeta Crédito', -800.00)];

    // Ingresos simulados
    final ingresos = [
      ('Salario', 2500.00, Icons.payments_outlined),
      ('Transferencia', 450.00, Icons.swap_horiz_outlined),
      ('Intereses', 40.00, Icons.percent_outlined),
    ];
    final totalIngresos = ingresos.fold<double>(0, (s, i) => s + i.$2);

    final totalCuentas = cuentas.fold<double>(0, (a, b) => a + b.$2);
    final totalTarjetas = tarjetas.fold<double>(0, (a, b) => a + b.$2);
    final total = efectivo + totalCuentas + totalTarjetas;

    double pct(num v) => total <= 0 ? 0 : (v / total).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: AppColors.bgSoft,
      appBar: AppBar(
        title: const Text('Balance Total'),
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),

      // ---------------- CUERPO ----------------
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          16,
          16,
          16,
          120,
        ), // deja espacio a la barra
        children: [
          // -------- Resumen --------
          _Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Resumen General',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    color: AppColors.textStrong,
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: EcoSummaryTile(
                        label: 'Total',
                        amount: total,
                        strong: true,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        children: [
                          EcoDistBar(
                            label: 'Efectivo',
                            value: efectivo,
                            pct: pct(efectivo),
                            color: AppColors.ecoGreen,
                          ),
                          const SizedBox(height: 8),
                          EcoDistBar(
                            label: 'Cuentas',
                            value: totalCuentas,
                            pct: pct(totalCuentas),
                            color: const Color(0xFF2D9CDB),
                          ),
                          const SizedBox(height: 8),
                          EcoDistBar(
                            label: 'Tarjetas',
                            value: totalTarjetas,
                            pct: pct(totalTarjetas.abs()),
                            color: AppColors.danger,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // -------- Efectivo --------
          _Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const EcoSectionHeader(
                  icon: Icons.payments_outlined,
                  title: 'Efectivo',
                ),
                const SizedBox(height: 8),
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  leading: const EcoDot(color: AppColors.ecoGreen),
                  title: const Text('Billetera'),
                  trailing: Text(
                    _money(efectivo, showSign: false),
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: AppColors.ok,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // -------- Cuentas Bancarias --------
          _Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const EcoSectionHeader(
                  icon: Icons.account_balance_outlined,
                  title: 'Cuentas Bancarias',
                ),
                const SizedBox(height: 8),
                for (final c in cuentas) ...[
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    leading: const EcoDot(color: Color(0xFF2D9CDB)),
                    title: Text(
                      c.$1,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    trailing: Text(
                      _money(c.$2, showSign: false),
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        color: AppColors.textStrong,
                      ),
                    ),
                  ),
                ],
                const Divider(),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Subtotal: ${_money(totalCuentas, showSign: false)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textStrong,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // -------- Tarjetas --------
          _Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const EcoSectionHeader(
                  icon: Icons.credit_card_outlined,
                  title: 'Tarjetas',
                ),
                const SizedBox(height: 8),
                for (final t in tarjetas) ...[
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    leading: const EcoDot(color: AppColors.danger),
                    title: Text(
                      t.$1,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    trailing: Text(
                      _money(t.$2),
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        color: AppColors.danger,
                      ),
                    ),
                  ),
                ],
                const Divider(),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Total tarjetas: ${_money(totalTarjetas)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.danger,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // -------- Ingresos --------
          _Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const EcoSectionHeader(
                  icon: Icons.trending_up_outlined,
                  title: 'Ingresos',
                ),
                const SizedBox(height: 8),
                for (final i in ingresos) ...[
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(i.$3, color: AppColors.ok),
                    title: Text(
                      i.$1,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    trailing: Text(
                      _money(i.$2, showSign: false),
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        color: AppColors.ok,
                      ),
                    ),
                  ),
                ],
                const Divider(),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Total ingresos: ${_money(totalIngresos, showSign: false)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textStrong,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text('Registrar ingreso'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.ecoGreen,
                      side: const BorderSide(color: AppColors.ecoGreen),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => _openAddIncomeSheet(context),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // -------- CTA / Nota --------
          _Card(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.tips_and_updates_outlined,
                  color: AppColors.ecoGreen,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    '💡 Consejo: Mantén 3–6 meses de gastos en tu cuenta de ahorro.\n'
                    'Actualmente tienes ${_money(total, showSign: false)} en total.',
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // ---------- FAB central con logo ----------
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _LogoFab(
        onTap: () => Navigator.pushNamedAndRemoveUntil(
          context,
          '/dashboard',
          (r) => false,
        ),
      ),

      // ---------- Barra inferior (Acciones rápidas) ----------
      bottomNavigationBar: _BottomActionsBar(
        left: const [
          _Action(icon: Icons.add, label: 'Gasto'),
          _Action(icon: Icons.show_chart_outlined, label: 'Ingreso'),
          _Action(icon: Icons.local_offer_outlined, label: 'Categorías'),
        ],
        right: const [
          _Action(icon: Icons.bar_chart_outlined, label: 'Reportes'),
          _Action(icon: Icons.calendar_today_outlined, label: 'Calendario'),
          _Action(icon: Icons.notifications_none, label: 'Notifs'),
        ],
        onPressed: (label) {
          switch (label) {
            case 'Gasto':
              Navigator.pushNamed(context, '/gastos');
              break;
            case 'Ingreso':
              Navigator.pushNamed(
                context,
                '/balance',
              ); // lleva a tu vista de ingresos si la tienes
              break;
            case 'Categorías':
              Navigator.pushNamed(context, '/categorias');
              break;
            case 'Reportes':
              Navigator.pushNamed(context, '/reportes');
              break;
            case 'Calendario':
              Navigator.pushNamed(context, '/calendario');
              break;
            case 'Notifs':
              Navigator.pushNamed(context, '/notifs');
              break;
            default:
              _snack(context, 'Ruta no definida: $label');
          }
        },
      ),
    );
  }
}

// ================== WIDGETS PÚBLICOS COMPARTIBLES ==================
class EcoSectionHeader extends StatelessWidget {
  const EcoSectionHeader({super.key, required this.icon, required this.title});
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.ecoGreen),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            color: AppColors.textStrong,
          ),
        ),
      ],
    );
  }
}

class EcoDot extends StatelessWidget {
  const EcoDot({super.key, required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}

class EcoDistBar extends StatelessWidget {
  const EcoDistBar({
    super.key,
    required this.label,
    required this.value,
    required this.pct, // 0..1
    required this.color,
  });

  final String label;
  final double value;
  final double pct;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final w = pct.clamp(0.0, 1.0);
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(fontSize: 13, color: Colors.black87),
              ),
            ),
            Text(
              _money(value, showSign: false),
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: SizedBox(
            height: 10,
            child: Stack(
              children: [
                Container(color: Colors.grey.shade300),
                FractionallySizedBox(
                  widthFactor: w,
                  child: Container(color: color),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class EcoSummaryTile extends StatelessWidget {
  const EcoSummaryTile({
    super.key,
    required this.label,
    required this.amount,
    this.strong = false,
  });
  final String label;
  final double amount;
  final bool strong;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.black54)),
          const SizedBox(height: 6),
          Text(
            _money(amount, showSign: false),
            style: TextStyle(
              fontSize: 22,
              fontWeight: strong ? FontWeight.w900 : FontWeight.w800,
              color: AppColors.textStrong,
            ),
          ),
        ],
      ),
    );
  }
}

// -------- GASTOS DETAIL SCREEN (completa y sin errores) --------
class GastosDetailScreen extends StatelessWidget {
  const GastosDetailScreen({super.key});

  void _snack(BuildContext ctx, String msg) =>
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(msg)));

  void _goByLabel(BuildContext context, String label) {
    switch (label) {
      case 'Gasto':
        _openAddGasto(context); // abre el formulario
        break;
      case 'Ingreso':
        Navigator.pushNamed(context, '/balance');
        break;
      case 'Categorías':
        Navigator.pushNamed(context, '/categorias');
        break;
      case 'Reportes':
        Navigator.pushNamed(context, '/reportes');
        break;
      case 'Calendario':
        Navigator.pushNamed(context, '/calendario');
        break;
      case 'Notifs':
        Navigator.pushNamed(context, '/notifs');
        break;
      default:
        _snack(context, 'Ruta no definida: $label');
    }
  }

  // ------ abre el bottom sheet con el formulario ------
  void _openAddGasto(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: const _AddGastoSheet(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ----- Datos mock del mes -----
    const double totalMes = 3240.00;
    const double variacion = 0.082; // +8.2%

    final categorias = <_GCategory>[
      _GCategory('Alimentación', 950.00, const Color(0xFF7CB342)),
      _GCategory('Transporte', 420.00, const Color(0xFF29B6F6)),
      _GCategory('Entretenimiento', 380.00, const Color(0xFFAB47BC)),
      _GCategory('Vivienda', 980.00, const Color(0xFFFF7043)),
      _GCategory('Otros', 510.00, const Color(0xFF9E9E9E)),
    ];
    final gastos = <_GastoItem>[
      _GastoItem('Supermercado', 'Alimentación • Hoy', -85.50),
      _GastoItem('Gasolina', 'Transporte • Ayer', -45.00),
      _GastoItem('Netflix', 'Entretenimiento • 3 días', -12.99),
      _GastoItem('Renta', 'Vivienda • 5 días', -780.00),
      _GastoItem('Cine', 'Entretenimiento • 1 semana', -9.50),
    ];
    final maxCat = categorias.fold<double>(
      0,
      (a, b) => b.monto > a ? b.monto : a,
    );

    return Scaffold(
      backgroundColor: AppColors.bgSoft,
      appBar: AppBar(
        title: const Text('Gastos del Mes'),
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () => _snack(context, 'Filtrar'),
            icon: const Icon(Icons.tune, color: AppColors.textStrong),
            tooltip: 'Filtros',
          ),
        ],
      ),

      // -------- CUERPO --------
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
        children: [
          // Resumen del mes
          _Card(
            child: Row(
              children: [
                // Lado izquierdo: totales
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Total del mes',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: AppColors.textStrong,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _money(-totalMes),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: AppColors.danger,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(
                            variacion >= 0
                                ? Icons.north_east
                                : Icons.south_east,
                            size: 16,
                            color: variacion >= 0
                                ? AppColors.danger
                                : AppColors.ok,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${(variacion * 100).toStringAsFixed(1)}% vs mes anterior',
                            style: TextStyle(
                              fontSize: 12,
                              color: variacion >= 0
                                  ? AppColors.danger
                                  : AppColors.ok,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // Lado derecho: filtros rápidos
                const Expanded(child: _GastosFilterChips()),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Desglose por categorías
          _Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Por categoría',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: AppColors.textStrong,
                  ),
                ),
                const SizedBox(height: 12),
                for (final c in categorias) ...[
                  _GCategoryBar(
                    name: c.nombre,
                    amount: c.monto,
                    pct: maxCat == 0 ? 0 : (c.monto / maxCat).clamp(0.0, 1.0),
                    color: c.color,
                  ),
                  const SizedBox(height: 10),
                ],
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Total: ${_money(-totalMes, showSign: false)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textStrong,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Lista de gastos
          _Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Gastos recientes',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: AppColors.textStrong,
                  ),
                ),
                const SizedBox(height: 10),
                for (int i = 0; i < gastos.length; i++) ...[
                  _GastoTile(item: gastos[i]),
                  if (i != gastos.length - 1) const Divider(height: 10),
                ],
                const SizedBox(height: 6),
                Align(
                  alignment: Alignment.centerRight,
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text('Agregar gasto'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.ecoGreen,
                      side: const BorderSide(color: AppColors.ecoGreen),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => _openAddGasto(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // ---------- FAB central con logo ----------
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _LogoFab(
        onTap: () => Navigator.pushNamedAndRemoveUntil(
          context,
          '/dashboard',
          (r) => false,
        ),
      ),

      // ---------- Barra inferior (Acciones rápidas) ----------
      bottomNavigationBar: _BottomActionsBar(
        left: const [
          _Action(icon: Icons.add, label: 'Gasto'),
          _Action(icon: Icons.show_chart_outlined, label: 'Ingreso'),
          _Action(icon: Icons.local_offer_outlined, label: 'Categorías'),
        ],
        right: const [
          _Action(icon: Icons.bar_chart_outlined, label: 'Reportes'),
          _Action(icon: Icons.calendar_today_outlined, label: 'Calendario'),
          _Action(icon: Icons.notifications_none, label: 'Notifs'),
        ],
        onPressed: (label) => _goByLabel(context, label),
      ),
    );
  }
}

/// ====== MODELOS LOCALES ======
class _GCategory {
  _GCategory(this.nombre, this.monto, this.color);
  final String nombre;
  final double monto;
  final Color color;
}

class _GastoItem {
  _GastoItem(this.titulo, this.subtitulo, this.monto);
  final String titulo;
  final String subtitulo; // p.ej. "Alimentación • Hoy"
  final double monto; // negativo
}

/// ====== WIDGETS AUXILIARES ======
class _GCategoryBar extends StatelessWidget {
  const _GCategoryBar({
    required this.name,
    required this.amount,
    required this.pct,
    required this.color,
  });

  final String name;
  final double amount;
  final double pct; // 0..1
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(name, style: const TextStyle(color: Colors.black87)),
            ),
            Text(
              _money(-amount, showSign: false),
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: SizedBox(
            height: 10,
            child: Stack(
              children: [
                Container(color: Colors.grey.shade300),
                FractionallySizedBox(
                  widthFactor: pct,
                  child: Container(color: color),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _GastoTile extends StatelessWidget {
  const _GastoTile({required this.item});
  final _GastoItem item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.remove_circle_outline, color: AppColors.danger),
      title: Text(
        item.titulo,
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
      subtitle: Text(
        item.subtitulo,
        style: const TextStyle(fontSize: 12, color: Colors.black54),
      ),
      trailing: Text(
        _money(item.monto),
        style: const TextStyle(
          fontWeight: FontWeight.w800,
          color: AppColors.danger,
        ),
      ),
    );
  }
}

class _GastosFilterChips extends StatefulWidget {
  const _GastosFilterChips();

  @override
  State<_GastosFilterChips> createState() => _GastosFilterChipsState();
}

class _GastosFilterChipsState extends State<_GastosFilterChips> {
  final _opts = ['Mes actual', 'Últimos 30 días', 'Este año'];
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: -6,
      alignment: WrapAlignment.end,
      children: List.generate(_opts.length, (i) {
        final selected = i == _selected;
        return ChoiceChip(
          label: Text(_opts[i]),
          selected: selected,
          onSelected: (_) => setState(() => _selected = i),
          selectedColor: AppColors.ecoGreen.withOpacity(.12),
          labelStyle: TextStyle(
            color: selected ? AppColors.ecoGreen : Colors.black87,
            fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          side: BorderSide(
            color: selected ? AppColors.ecoGreen : Colors.grey.shade300,
          ),
        );
      }),
    );
  }
}

/// ====== BottomSheet: Formulario Agregar Gasto ======
class _AddGastoSheet extends StatefulWidget {
  const _AddGastoSheet();

  @override
  State<_AddGastoSheet> createState() => _AddGastoSheetState();
}

class _AddGastoSheetState extends State<_AddGastoSheet> {
  final _formKey = GlobalKey<FormState>();
  final _montoCtrl = TextEditingController();
  final _notaCtrl = TextEditingController();
  DateTime _fecha = DateTime.now();
  String _categoria = 'Alimentación';

  @override
  void dispose() {
    _montoCtrl.dispose();
    _notaCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickFecha() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _fecha,
      firstDate: DateTime.now().subtract(const Duration(days: 365 * 5)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );
    if (picked != null) setState(() => _fecha = picked);
  }

  void _guardar() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final monto = double.tryParse(_montoCtrl.text.replaceAll(',', '.')) ?? 0;
    final snack = SnackBar(
      content: Text(
        'Gasto guardado: ${_money(-monto)} • $_categoria • ${_fecha.day}/${_fecha.month}/${_fecha.year}'
        '${_notaCtrl.text.isNotEmpty ? ' • Nota: ${_notaCtrl.text}' : ''}',
      ),
    );

    Navigator.pop(context); // cerrar sheet
    ScaffoldMessenger.of(context).showSnackBar(snack);
    // Aquí podrías persistir el gasto
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 20),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min, // se ajusta al contenido
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Agregar gasto',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 18,
                color: AppColors.textStrong,
              ),
            ),
            const SizedBox(height: 12),

            // Monto
            TextFormField(
              controller: _montoCtrl,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: 'Monto',
                prefixIcon: const Icon(Icons.attach_money),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (v) {
                final val = double.tryParse((v ?? '').replaceAll(',', '.'));
                if (val == null || val <= 0) return 'Ingresa un monto válido';
                return null;
              },
            ),
            const SizedBox(height: 12),

            // Categoría
            DropdownButtonFormField<String>(
              value: _categoria,
              decoration: InputDecoration(
                labelText: 'Categoría',
                prefixIcon: const Icon(Icons.local_offer_outlined),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Alimentación',
                  child: Text('Alimentación'),
                ),
                DropdownMenuItem(
                  value: 'Transporte',
                  child: Text('Transporte'),
                ),
                DropdownMenuItem(
                  value: 'Entretenimiento',
                  child: Text('Entretenimiento'),
                ),
                DropdownMenuItem(value: 'Vivienda', child: Text('Vivienda')),
                DropdownMenuItem(value: 'Otros', child: Text('Otros')),
              ],
              onChanged: (v) => setState(() => _categoria = v ?? _categoria),
            ),
            const SizedBox(height: 12),

            // Fecha
            InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: _pickFecha,
              child: InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Fecha',
                  prefixIcon: const Icon(Icons.event_outlined),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                child: Text(
                  '${_fecha.day}/${_fecha.month}/${_fecha.year}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Nota
            TextField(
              controller: _notaCtrl,
              maxLines: 2,
              decoration: InputDecoration(
                labelText: 'Nota (opcional)',
                prefixIcon: const Icon(Icons.sticky_note_2_outlined),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Botones
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black87,
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Cancelar'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _guardar,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.ecoGreen,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      'Guardar',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
          ],
        ),
      ),
    );
  }
}

// -------- AHORROS DETAIL SCREEN (completa) --------
class AhorrosDetailScreen extends StatelessWidget {
  const AhorrosDetailScreen({super.key});

  void _snack(BuildContext ctx, String msg) =>
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(msg)));

  void _goByLabel(BuildContext context, String label) {
    switch (label) {
      case 'Gasto':
        Navigator.pushNamed(context, '/gastos');
        break;
      case 'Ingreso':
        Navigator.pushNamed(context, '/balance');
        break;
      case 'Categorías':
        Navigator.pushNamed(context, '/categorias');
        break;
      case 'Reportes':
        Navigator.pushNamed(context, '/reportes');
        break;
      case 'Calendario':
        Navigator.pushNamed(context, '/calendario');
        break;
      case 'Notifs':
        Navigator.pushNamed(context, '/notifs');
        break;
      default:
        _snack(context, 'Ruta no definida: $label');
    }
  }

  void _openAddAhorro(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: const _AddAhorroSheet(),
      ),
    );
  }

  void _openAddMeta(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: const _AddMetaSheet(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ---- Datos mock ----
    const double totalAhorrado = 8750.00;
    const double rendimientoMes = 0.012; // +1.2% mensual

    final metas = <_MetaAhorro>[
      _MetaAhorro('Fondo de emergencia', 5000, 3500, const Color(0xFF2D9CDB)),
      _MetaAhorro('Viaje', 3000, 2200, const Color(0xFFFF7043)),
      _MetaAhorro('Laptop nueva', 1800, 1050, const Color(0xFF7CB342)),
    ];

    final depositos = <_DepositoItem>[
      _DepositoItem('Fondo de emergencia', 200.00, 'Hoy'),
      _DepositoItem('Viaje', 150.00, 'Ayer'),
      _DepositoItem('Laptop nueva', 80.00, 'Hace 3 días'),
    ];

    return Scaffold(
      backgroundColor: AppColors.bgSoft,
      appBar: AppBar(
        title: const Text('Ahorros'),
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () => _snack(context, 'Configurar metas'),
            icon: const Icon(
              Icons.settings_outlined,
              color: AppColors.textStrong,
            ),
            tooltip: 'Configurar metas',
          ),
        ],
      ),

      // -------- CUERPO --------
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
        children: [
          // Resumen
          _Card(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Total ahorrado',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: AppColors.textStrong,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _money(totalAhorrado, showSign: false),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: AppColors.textStrong,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(
                            rendimientoMes >= 0
                                ? Icons.north_east
                                : Icons.south_east,
                            size: 16,
                            color: rendimientoMes >= 0
                                ? AppColors.ok
                                : AppColors.danger,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${(rendimientoMes * 100).toStringAsFixed(1)}% este mes',
                            style: TextStyle(
                              fontSize: 12,
                              color: rendimientoMes >= 0
                                  ? AppColors.ok
                                  : AppColors.danger,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  children: [
                    OutlinedButton.icon(
                      onPressed: () => _openAddAhorro(context),
                      icon: const Icon(Icons.add),
                      label: const Text('Agregar ahorro'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.ecoGreen,
                        side: const BorderSide(color: AppColors.ecoGreen),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: () => _openAddMeta(context),
                      icon: const Icon(Icons.flag_outlined),
                      label: const Text('Nueva meta'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.ecoGreen,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Metas
          _Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Mis metas',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: AppColors.textStrong,
                  ),
                ),
                const SizedBox(height: 12),
                for (final m in metas) ...[
                  _MetaTile(meta: m),
                  const SizedBox(height: 10),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Depósitos recientes
          _Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Depósitos recientes',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: AppColors.textStrong,
                  ),
                ),
                const SizedBox(height: 10),
                for (int i = 0; i < depositos.length; i++) ...[
                  _DepositoTile(item: depositos[i]),
                  if (i != depositos.length - 1) const Divider(height: 10),
                ],
              ],
            ),
          ),
        ],
      ),

      // ---------- FAB central con logo ----------
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _LogoFab(
        onTap: () => Navigator.pushNamedAndRemoveUntil(
          context,
          '/dashboard',
          (r) => false,
        ),
      ),

      // ---------- Barra inferior (Acciones rápidas) ----------
      bottomNavigationBar: _BottomActionsBar(
        left: const [
          _Action(icon: Icons.add, label: 'Gasto'),
          _Action(icon: Icons.show_chart_outlined, label: 'Ingreso'),
          _Action(icon: Icons.local_offer_outlined, label: 'Categorías'),
        ],
        right: const [
          _Action(icon: Icons.bar_chart_outlined, label: 'Reportes'),
          _Action(icon: Icons.calendar_today_outlined, label: 'Calendario'),
          _Action(icon: Icons.notifications_none, label: 'Notifs'),
        ],
        onPressed: (label) => _goByLabel(context, label),
      ),
    );
  }
}

/// ====== MODELOS LOCALES ======
class _MetaAhorro {
  _MetaAhorro(this.nombre, this.meta, this.actual, this.color);
  final String nombre;
  final double meta;
  final double actual;
  final Color color;
}

class _DepositoItem {
  _DepositoItem(this.meta, this.monto, this.fecha);
  final String meta;
  final double monto;
  final String fecha; // texto simple
}

/// ====== WIDGETS AUXILIARES ======
class _MetaTile extends StatelessWidget {
  const _MetaTile({required this.meta});
  final _MetaAhorro meta;

  @override
  Widget build(BuildContext context) {
    final pct = meta.meta <= 0
        ? 0.0
        : (meta.actual / meta.meta).clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.savings_outlined, color: meta.color),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  meta.nombre,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textStrong,
                  ),
                ),
              ),
              Text(
                '${(pct * 100).toStringAsFixed(0)}%',
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  color: AppColors.textStrong,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 10,
              child: Stack(
                children: [
                  Container(color: Colors.grey.shade300),
                  FractionallySizedBox(
                    widthFactor: pct,
                    child: Container(color: meta.color),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                _money(meta.actual, showSign: false),
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              const Spacer(),
              Text(
                'Meta: ${_money(meta.meta, showSign: false)}',
                style: const TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DepositoTile extends StatelessWidget {
  const _DepositoTile({required this.item});
  final _DepositoItem item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.arrow_downward, color: AppColors.ok),
      title: Text(
        item.meta,
        style: const TextStyle(fontWeight: FontWeight.w700),
      ),
      subtitle: Text(
        item.fecha,
        style: const TextStyle(fontSize: 12, color: Colors.black54),
      ),
      trailing: Text(
        _money(item.monto, showSign: false),
        style: const TextStyle(
          fontWeight: FontWeight.w800,
          color: AppColors.ok,
        ),
      ),
    );
  }
}

/// ====== BottomSheet: Formulario agregar ahorro ======
class _AddAhorroSheet extends StatefulWidget {
  const _AddAhorroSheet();

  @override
  State<_AddAhorroSheet> createState() => _AddAhorroSheetState();
}

class _AddAhorroSheetState extends State<_AddAhorroSheet> {
  final _formKey = GlobalKey<FormState>();
  final _montoCtrl = TextEditingController();
  String _metaSel = 'Fondo de emergencia';
  DateTime _fecha = DateTime.now();

  @override
  void dispose() {
    _montoCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickFecha() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _fecha,
      firstDate: DateTime.now().subtract(const Duration(days: 365 * 5)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );
    if (picked != null) setState(() => _fecha = picked);
  }

  void _guardar() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final monto = double.tryParse(_montoCtrl.text.replaceAll(',', '.')) ?? 0;
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Ahorro agregado: ${_money(monto, showSign: false)} a $_metaSel (${_fecha.day}/${_fecha.month}/${_fecha.year})',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 20),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Agregar ahorro',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 18,
                color: AppColors.textStrong,
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _metaSel,
              decoration: _dec('Meta', Icons.flag_outlined),
              items: const [
                DropdownMenuItem(
                  value: 'Fondo de emergencia',
                  child: Text('Fondo de emergencia'),
                ),
                DropdownMenuItem(value: 'Viaje', child: Text('Viaje')),
                DropdownMenuItem(
                  value: 'Laptop nueva',
                  child: Text('Laptop nueva'),
                ),
              ],
              onChanged: (v) => setState(() => _metaSel = v ?? _metaSel),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _montoCtrl,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: _dec('Monto', Icons.attach_money),
              validator: (v) {
                final val = double.tryParse((v ?? '').replaceAll(',', '.'));
                if (val == null || val <= 0) return 'Ingresa un monto válido';
                return null;
              },
            ),
            const SizedBox(height: 12),
            InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: _pickFecha,
              child: InputDecorator(
                decoration: _dec('Fecha', Icons.event_outlined),
                child: Text(
                  '${_fecha.day}/${_fecha.month}/${_fecha.year}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black87,
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Cancelar'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _guardar,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.ecoGreen,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      'Guardar',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _dec(String label, IconData icon) => InputDecoration(
    labelText: label,
    prefixIcon: Icon(icon),
    filled: true,
    fillColor: Colors.grey[100],
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  );
}

/// ====== BottomSheet: Formulario crear meta ======
class _AddMetaSheet extends StatefulWidget {
  const _AddMetaSheet();

  @override
  State<_AddMetaSheet> createState() => _AddMetaSheetState();
}

class _AddMetaSheetState extends State<_AddMetaSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nombreCtrl = TextEditingController();
  final _metaCtrl = TextEditingController();
  final _ahorroInicialCtrl = TextEditingController();

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _metaCtrl.dispose();
    _ahorroInicialCtrl.dispose();
    super.dispose();
  }

  void _guardar() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final nombre = _nombreCtrl.text.trim();
    final meta = double.tryParse(_metaCtrl.text.replaceAll(',', '.')) ?? 0;
    final ini =
        double.tryParse(_ahorroInicialCtrl.text.replaceAll(',', '.')) ?? 0;
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Meta creada: $nombre • ${_money(meta, showSign: false)} (Inicial: ${_money(ini, showSign: false)})',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 20),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nueva meta de ahorro',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 18,
                color: AppColors.textStrong,
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _nombreCtrl,
              decoration: _dec('Nombre de la meta', Icons.flag_outlined),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Ingresa un nombre' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _metaCtrl,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: _dec('Monto objetivo', Icons.savings_outlined),
              validator: (v) {
                final val = double.tryParse((v ?? '').replaceAll(',', '.'));
                if (val == null || val <= 0) return 'Ingresa un monto válido';
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _ahorroInicialCtrl,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: _dec('Ahorro inicial (opcional)', Icons.attach_money),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black87,
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Cancelar'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _guardar,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.ecoGreen,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      'Crear meta',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _dec(String label, IconData icon) => InputDecoration(
    labelText: label,
    prefixIcon: Icon(icon),
    filled: true,
    fillColor: Colors.grey[100],
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  );
}

// -------- INGRESOS --------
class IngresosDetailScreen extends StatelessWidget {
  const IngresosDetailScreen({super.key});

  void _goByLabel(BuildContext context, String label) {
    switch (label) {
      case 'Gasto':
        Navigator.pushNamed(context, '/gastos');
        break;
      case 'Ingreso':
        Navigator.pushNamed(context, '/balance');
        break;
      case 'Categorías':
        Navigator.pushNamed(context, '/categorias');
        break;
      case 'Reportes':
        Navigator.pushNamed(context, '/reportes');
        break;
      case 'Calendario':
        Navigator.pushNamed(context, '/calendario');
        break;
      case 'Notifs':
        Navigator.pushNamed(context, '/notifs');
        break;
      default:
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Ruta no definida: $label')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgSoft,
      appBar: AppBar(
        title: const Text('Ingresos'),
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: const Center(
        child: Text(
          '🟢 Lista de ingresos, filtros y totales',
          style: TextStyle(fontSize: 16, color: AppColors.textStrong),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _LogoFab(
        onTap: () => Navigator.pushNamedAndRemoveUntil(
          context,
          '/dashboard',
          (r) => false,
        ),
      ),
      bottomNavigationBar: _BottomActionsBar(
        left: const [
          _Action(icon: Icons.add, label: 'Gasto'),
          _Action(icon: Icons.show_chart_outlined, label: 'Ingreso'),
          _Action(icon: Icons.local_offer_outlined, label: 'Categorías'),
        ],
        right: const [
          _Action(icon: Icons.bar_chart_outlined, label: 'Reportes'),
          _Action(icon: Icons.calendar_today_outlined, label: 'Calendario'),
          _Action(icon: Icons.notifications_none, label: 'Notifs'),
        ],
        onPressed: (label) => _goByLabel(context, label),
      ),
    );
  }
}

// -------- CATEGORÍAS --------
class CategoriasScreen extends StatelessWidget {
  const CategoriasScreen({super.key});

  // ---- Mock de categorías ----
  List<_CategoryItem> get _gastosMock => const [
    _CategoryItem(
      'Alimentación',
      Icons.restaurant_outlined,
      Color(0xFFEF5350),
      12,
    ),
    _CategoryItem(
      'Transporte',
      Icons.directions_bus_outlined,
      Color(0xFF42A5F5),
      7,
    ),
    _CategoryItem('Servicios', Icons.bolt_outlined, Color(0xFFFFB300), 5),
    _CategoryItem('Entretenimiento', Icons.tv_outlined, Color(0xFFAB47BC), 4),
  ];
  List<_CategoryItem> get _ingresosMock => const [
    _CategoryItem('Salario', Icons.payments_outlined, Color(0xFF66BB6A), 2),
    _CategoryItem('Freelance', Icons.work_outline, Color(0xFF26C6DA), 3),
    _CategoryItem('Intereses', Icons.percent_outlined, Color(0xFF7E57C2), 1),
  ];

  void _goByLabel(BuildContext context, String label) {
    switch (label) {
      case 'Gasto':
        Navigator.pushNamed(context, '/gastos');
        break;
      case 'Ingreso':
        Navigator.pushNamed(context, '/balance');
        break;
      case 'Categorías':
        Navigator.pushNamed(context, '/categorias');
        break;
      case 'Reportes':
        Navigator.pushNamed(context, '/reportes');
        break;
      case 'Calendario':
        Navigator.pushNamed(context, '/calendario');
        break;
      case 'Notifs':
        Navigator.pushNamed(context, '/notifs');
        break;
      default:
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Ruta no definida: $label')));
    }
  }

  void _openCategoryForm(
    BuildContext context, {
    required bool esGasto,
    _CategoryItem? current,
  }) {
    final formKey = GlobalKey<FormState>();
    final nameCtrl = TextEditingController(text: current?.name ?? '');
    IconData icon =
        current?.icon ??
        (esGasto ? Icons.category_outlined : Icons.trending_up_outlined);
    Color color =
        current?.color ??
        (esGasto ? const Color(0xFFEF5350) : const Color(0xFF66BB6A));

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
            top: 16,
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      esGasto
                          ? Icons.local_offer_outlined
                          : Icons.trending_up_outlined,
                      color: AppColors.ecoGreen,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      current == null
                          ? 'Nueva categoría de ${esGasto ? 'gasto' : 'ingreso'}'
                          : 'Editar categoría',
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        color: AppColors.textStrong,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Nombre de la categoría',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'Ingresa un nombre'
                      : null,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    // Selector de icono sencillo (ciclo por opciones)
                    _IconChip(
                      selected: true,
                      icon: icon,
                      onTap: () {
                        // alternar entre algunos íconos rápidos
                        final opciones = esGasto
                            ? [
                                Icons.restaurant_outlined,
                                Icons.directions_bus_outlined,
                                Icons.bolt_outlined,
                                Icons.tv_outlined,
                                Icons.shopping_cart_outlined,
                                Icons.pets_outlined,
                              ]
                            : [
                                Icons.payments_outlined,
                                Icons.work_outline,
                                Icons.percent_outlined,
                                Icons.card_giftcard_outlined,
                                Icons.savings_outlined,
                                Icons.trending_up_outlined,
                              ];
                        final idx = opciones.indexOf(icon);
                        icon = opciones[(idx + 1) % opciones.length];
                      },
                    ),
                    const SizedBox(width: 12),
                    // Selector de color rápido (muestra el actual grande + paleta)
                    _ColorPickerRow(color: color, onChanged: (c) => color = c),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.check),
                    label: Text(
                      current == null ? 'Crear categoría' : 'Guardar cambios',
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.ecoGreen,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              current == null
                                  ? 'Categoría creada: ${nameCtrl.text}'
                                  : 'Categoría actualizada: ${nameCtrl.text}',
                            ),
                          ),
                        );
                        // TODO: aquí iría tu lógica real para persistir.
                      }
                    },
                  ),
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final gastos = _gastosMock;
    final ingresos = _ingresosMock;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.bgSoft,
        appBar: AppBar(
          title: const Text('Categorías'),
          backgroundColor: Colors.white,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          bottom: const TabBar(
            labelColor: AppColors.textStrong,
            indicatorColor: AppColors.ecoGreen,
            tabs: [
              Tab(text: 'Gastos'),
              Tab(text: 'Ingresos'),
            ],
          ),
          actions: [
            IconButton(
              tooltip: 'Nueva categoría (gasto)',
              onPressed: () => _openCategoryForm(context, esGasto: true),
              icon: const Icon(Icons.add),
            ),
          ],
        ),

        body: TabBarView(
          children: [
            // ------- TAB: GASTOS -------
            ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
              children: [
                _Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tus categorías de gasto',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: AppColors.textStrong,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Buscar categoría...',
                          isDense: true,
                          prefixIcon: const Icon(Icons.search),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        onChanged: (_) {},
                      ),
                      const SizedBox(height: 12),
                      for (final c in gastos)
                        _CategoryTile(
                          item: c,
                          onEdit: () => _openCategoryForm(
                            context,
                            esGasto: true,
                            current: c,
                          ),
                          onDelete: () =>
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Eliminar ${c.name} (demo)'),
                                ),
                              ),
                        ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.add),
                          label: const Text('Agregar categoría'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.ecoGreen,
                            side: const BorderSide(color: AppColors.ecoGreen),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () =>
                              _openCategoryForm(context, esGasto: true),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // ------- TAB: INGRESOS -------
            ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
              children: [
                _Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tus categorías de ingreso',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: AppColors.textStrong,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Buscar categoría...',
                          isDense: true,
                          prefixIcon: const Icon(Icons.search),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        onChanged: (_) {},
                      ),
                      const SizedBox(height: 12),
                      for (final c in ingresos)
                        _CategoryTile(
                          item: c,
                          onEdit: () => _openCategoryForm(
                            context,
                            esGasto: false,
                            current: c,
                          ),
                          onDelete: () =>
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Eliminar ${c.name} (demo)'),
                                ),
                              ),
                        ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.add),
                          label: const Text('Agregar categoría'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.ecoGreen,
                            side: const BorderSide(color: AppColors.ecoGreen),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () =>
                              _openCategoryForm(context, esGasto: false),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),

        // ---------- FAB central con logo ----------
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _LogoFab(
          onTap: () => Navigator.pushNamedAndRemoveUntil(
            context,
            '/dashboard',
            (r) => false,
          ),
        ),

        // ---------- Barra inferior (Acciones rápidas) ----------
        bottomNavigationBar: _BottomActionsBar(
          left: const [
            _Action(icon: Icons.add, label: 'Gasto'),
            _Action(icon: Icons.show_chart_outlined, label: 'Ingreso'),
            _Action(icon: Icons.local_offer_outlined, label: 'Categorías'),
          ],
          right: const [
            _Action(icon: Icons.bar_chart_outlined, label: 'Reportes'),
            _Action(icon: Icons.calendar_today_outlined, label: 'Calendario'),
            _Action(icon: Icons.notifications_none, label: 'Notifs'),
          ],
          onPressed: (label) => _goByLabel(context, label),
        ),
      ),
    );
  }
}

/// ======= modelos + widgets locales =======
class _CategoryItem {
  final String name;
  final IconData icon;
  final Color color;
  final int count;
  const _CategoryItem(this.name, this.icon, this.color, this.count);
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({
    required this.item,
    required this.onEdit,
    required this.onDelete,
  });

  final _CategoryItem item;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          backgroundColor: item.color.withOpacity(.18),
          child: Icon(item.icon, color: item.color),
        ),
        title: Text(
          item.name,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColors.textStrong,
          ),
        ),
        subtitle: Text(
          '${item.count} ${item.count == 1 ? 'movimiento' : 'movimientos'}',
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}

class _IconChip extends StatelessWidget {
  const _IconChip({
    required this.selected,
    required this.icon,
    required this.onTap,
  });
  final bool selected;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? AppColors.ecoGreen : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Icono: '),
            Icon(icon, color: AppColors.textStrong),
          ],
        ),
      ),
    );
  }
}

class _ColorPickerRow extends StatelessWidget {
  const _ColorPickerRow({required this.color, required this.onChanged});
  final Color color;
  final ValueChanged<Color> onChanged;

  @override
  Widget build(BuildContext context) {
    final palette = <Color>[
      const Color(0xFFEF5350),
      const Color(0xFFFFB300),
      const Color(0xFF42A5F5),
      const Color(0xFFAB47BC),
      const Color(0xFF26C6DA),
      const Color(0xFF66BB6A),
      AppColors.ecoGreen,
    ];
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black12),
          ),
        ),
        const SizedBox(width: 8),
        Wrap(
          spacing: 8,
          children: [
            for (final c in palette)
              GestureDetector(
                onTap: () => onChanged(c),
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: c,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: c == color
                          ? AppColors.ecoGreenDark
                          : Colors.black12,
                      width: c == color ? 2 : 1,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

// -------- REPORTES --------
class ReportesScreen extends StatefulWidget {
  const ReportesScreen({super.key});
  @override
  State<ReportesScreen> createState() => _ReportesScreenState();
}

class _ReportesScreenState extends State<ReportesScreen> {
  // Filtros
  final _periodos = const ['Mes', '3M', 'Año'];
  final _tipos = const ['Ambos', 'Gastos', 'Ingresos'];
  String _periodoSel = 'Mes';
  String _tipoSel = 'Ambos';

  // Datos mock
  final _labels = const ['May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct'];
  final _gastosMes = const [1200.0, 980.0, 1100.0, 1350.0, 900.0, 1240.0];
  final _ingresosMes = const [2400.0, 2400.0, 2450.0, 2500.0, 2500.0, 2500.0];

  final _categorias = const <(String, double, double, Color)>[
    ('Alimentación', 420.0, .70, Color(0xFFEF5350)),
    ('Transporte', 180.0, .30, Color(0xFF42A5F5)),
    ('Servicios', 260.0, .50, Color(0xFFFFB300)),
    ('Entretenimiento', 120.0, .22, Color(0xFF7E57C2)),
    ('Otros', 260.0, .38, Color(0xFF78909C)),
  ];

  final _cuentas = const <(String, double, IconData)>[
    ('Cuenta Corriente', 6200.0, Icons.account_balance_outlined),
    ('Caja de Ahorro', 4700.0, Icons.savings_outlined),
    ('Efectivo', 2350.0, Icons.payments_outlined),
    ('Tarjeta Crédito', -800.0, Icons.credit_card_outlined),
  ];

  void _goByLabel(BuildContext context, String label) {
    switch (label) {
      case 'Gasto':
        Navigator.pushNamed(context, '/gastos');
        break;
      case 'Ingreso':
        Navigator.pushNamed(context, '/balance');
        break;
      case 'Categorías':
        Navigator.pushNamed(context, '/categorias');
        break;
      case 'Reportes':
        Navigator.pushNamed(context, '/reportes');
        break;
      case 'Calendario':
        Navigator.pushNamed(context, '/calendario');
        break;
      case 'Notifs':
        Navigator.pushNamed(context, '/notifs');
        break;
      default:
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Ruta no definida: $label')));
    }
  }

  double get _promGasto =>
      _gastosMes.fold(0.0, (s, v) => s + v) /
      (_gastosMes.isEmpty ? 1 : _gastosMes.length);
  double get _promIngreso =>
      _ingresosMes.fold(0.0, (s, v) => s + v) /
      (_ingresosMes.isEmpty ? 1 : _ingresosMes.length);
  double get _promBalance => _promIngreso - _promGasto;

  @override
  Widget build(BuildContext context) {
    final showGastos = _tipoSel != 'Ingresos';
    final showIngresos = _tipoSel != 'Gastos';

    return Scaffold(
      backgroundColor: AppColors.bgSoft,
      appBar: AppBar(
        title: const Text('Reportes'),
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),

      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 120),
        children: [
          // ===== Filtros (fijos arriba) =====
          _Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _SectionTitle('Filtros'),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: _Segmented<String>(
                        items: _periodos,
                        value: _periodoSel,
                        onChanged: (v) => setState(() => _periodoSel = v),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _Segmented<String>(
                        items: _tipos,
                        value: _tipoSel,
                        onChanged: (v) => setState(() => _tipoSel = v),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // ===== KPIs (nuevo diseño) =====
          SizedBox(
            height: 108,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 0),
              itemCount: 3,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, i) {
                switch (i) {
                  case 0:
                    return _StatPill(
                      label: 'Ingresos',
                      icon: Icons.trending_up_rounded,
                      iconColor: AppColors.ok,
                      value: _promIngreso,
                      sub: 'prom.',
                    );
                  case 1:
                    return _StatPill(
                      label: 'Gastos',
                      icon: Icons.trending_down_rounded,
                      iconColor: AppColors.danger,
                      value: _promGasto,
                      sub: 'prom.',
                    );
                  default:
                    return _StatPill(
                      label: 'Balance',
                      icon: Icons.account_balance_wallet_rounded,
                      iconColor: _promBalance >= 0
                          ? AppColors.ok
                          : AppColors.danger,
                      value: _promBalance,
                      sub: 'prom.',
                    );
                }
              },
            ),
          ),
          const SizedBox(height: 12),

          // ===== Gráfico =====
          _Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _SectionTitle('Evolución mensual'),
                const SizedBox(height: 10),
                SizedBox(
                  height: 190,
                  child: _MiniBarChart(
                    labels: _labels,
                    gastos: showGastos ? _gastosMes : null,
                    ingresos: showIngresos ? _ingresosMes : null,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 12,
                  children: const [
                    _LegendDot(text: 'Gastos', color: AppColors.danger),
                    _LegendDot(text: 'Ingresos', color: AppColors.ok),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // ===== Categorías =====
          if (showGastos)
            _Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _SectionTitle('Categorías principales'),
                  const SizedBox(height: 8),
                  for (final c in _categorias) ...[
                    _CategoryRow(
                      name: c.$1,
                      amount: c.$2,
                      progress: c.$3,
                      color: c.$4,
                    ),
                    const SizedBox(height: 10),
                  ],
                ],
              ),
            ),
          if (showGastos) const SizedBox(height: 12),

          // ===== Cuentas =====
          _Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _SectionTitle('Desglose por cuentas'),
                const SizedBox(height: 6),
                for (final c in _cuentas) ...[
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(c.$3, color: Colors.black54),
                    title: Text(c.$1),
                    trailing: Text(
                      _money(c.$2, showSign: false),
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: c.$2 >= 0
                            ? AppColors.textStrong
                            : AppColors.danger,
                      ),
                    ),
                  ),
                  Divider(color: Colors.grey.shade200, height: 8),
                ],
              ],
            ),
          ),
        ],
      ),

      // ===== FAB + Bottom bar =====
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _LogoFab(
        onTap: () => Navigator.pushNamedAndRemoveUntil(
          context,
          '/dashboard',
          (r) => false,
        ),
      ),
      bottomNavigationBar: _BottomActionsBar(
        left: const [
          _Action(icon: Icons.add, label: 'Gasto'),
          _Action(icon: Icons.show_chart_outlined, label: 'Ingreso'),
          _Action(icon: Icons.local_offer_outlined, label: 'Categorías'),
        ],
        right: const [
          _Action(icon: Icons.bar_chart_outlined, label: 'Reportes'),
          _Action(icon: Icons.calendar_today_outlined, label: 'Calendario'),
          _Action(icon: Icons.notifications_none, label: 'Notifs'),
        ],
        onPressed: (label) => _goByLabel(context, label),
      ),
    );
  }
}

/* ====== Widgets locales ====== */

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w800,
        color: AppColors.textStrong,
      ),
    );
  }
}

class _Segmented<T> extends StatelessWidget {
  const _Segmented({
    required this.items,
    required this.value,
    required this.onChanged,
  });

  final List<T> items;
  final T value;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.all(2),

      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: items.map((e) {
          final sel = e == value;
          return Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => onChanged(e),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: sel ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  e.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: sel ? AppColors.ecoGreenDark : Colors.black54,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _StatPill extends StatelessWidget {
  const _StatPill({
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.value,
    this.sub,
  });

  final String label;
  final IconData icon;
  final Color iconColor;
  final double value;
  final String? sub;

  @override
  Widget build(BuildContext context) {
    // Ancho fijo para uniformidad; ajusta si quieres más o menos compacto
    const double w = 160;

    return Container(
      width: w,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(color: Colors.black12.withOpacity(.04)),
      ),
      child: Row(
        children: [
          // Badge redondo para el icono
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(.12),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 10),
          // Texto
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Label (trunca con ellipsis si no entra)
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                    fontWeight: FontWeight.w700,
                    letterSpacing: .2,
                  ),
                ),
                const SizedBox(height: 2),
                // Valor
                Text(
                  _money(value, showSign: false),
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: AppColors.textStrong,
                    height: 1.1,
                  ),
                ),
                if (sub != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    sub!,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.black45,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _KpiCard extends StatelessWidget {
  const _KpiCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.fg,
  });

  final IconData icon;
  final String title;
  final double value;
  final Color fg;

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: fg.withOpacity(.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: fg),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
                const SizedBox(height: 4),
                Text(
                  _money(value, showSign: false),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: AppColors.textStrong,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniBarChart extends StatelessWidget {
  const _MiniBarChart({required this.labels, this.gastos, this.ingresos});

  final List<String> labels;
  final List<double>? gastos;
  final List<double>? ingresos;

  @override
  Widget build(BuildContext context) {
    final all = [...(gastos ?? []), ...(ingresos ?? [])];
    final maxVal =
        (all.isEmpty ? 1.0 : all.reduce((a, b) => a > b ? a : b)) * 1.2;

    return LayoutBuilder(
      builder: (context, c) {
        final barSpace = c.maxWidth / labels.length;
        final dual = (gastos != null && ingresos != null);
        final barWidth = (barSpace / (dual ? 2.6 : 1.6)).clamp(8.0, 26.0);

        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(labels.length, (i) {
            final g = (gastos != null && i < gastos!.length) ? gastos![i] : 0.0;
            final ing = (ingresos != null && i < ingresos!.length)
                ? ingresos![i]
                : 0.0;
            final gH = (g / maxVal) * 140;
            final iH = (ing / maxVal) * 140;

            return SizedBox(
              width: barSpace,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (gastos != null)
                        _Bar(
                          height: gH,
                          width: barWidth,
                          color: AppColors.danger,
                        ),
                      if (dual) const SizedBox(width: 6),
                      if (ingresos != null)
                        _Bar(height: iH, width: barWidth, color: AppColors.ok),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    labels[i],
                    style: const TextStyle(fontSize: 11, color: Colors.black54),
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}

class _Bar extends StatelessWidget {
  const _Bar({required this.height, required this.width, required this.color});
  final double height, width;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.text, required this.color});
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(.10),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(color: color, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class _CategoryRow extends StatelessWidget {
  const _CategoryRow({
    required this.name,
    required this.amount,
    required this.progress,
    required this.color,
  });
  final String name;
  final double amount;
  final double progress; // 0..1
  final Color color;

  @override
  Widget build(BuildContext context) {
    final p = progress.clamp(0.0, 1.0);
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 8),
            Expanded(child: Text(name)),
            Text(
              _money(amount, showSign: false),
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: AppColors.textStrong,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: SizedBox(
            height: 10,
            child: Stack(
              children: [
                Container(color: Colors.grey.shade300),
                FractionallySizedBox(
                  widthFactor: p,
                  child: Container(color: color.withOpacity(.85)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ================== CALENDARIO MEJORADO (con Deudas) ==================
class CalendarioScreen extends StatefulWidget {
  const CalendarioScreen({super.key});

  @override
  State<CalendarioScreen> createState() => _CalendarioScreenState();
}

class _CalendarioScreenState extends State<CalendarioScreen> {
  // Estado local de deudas (mock inicial + las que agregues)
  final List<_Debt> _debts = [
    _Debt(
      creditor: 'Banco X',
      amount: 450.00,
      start: DateTime.now().subtract(const Duration(days: 10)),
      months: 3,
      note: 'Cuota fija',
      remind: true,
    ),
    _Debt(
      creditor: 'Juan Pérez',
      amount: 120.00,
      start: DateTime.now(),
      months: 1,
      note: 'Préstamo corto',
      remind: false,
    ),
  ];

  // Eventos del día (mock corto para que se vea el calendario vivo)
  final List<_CalEvent> _today = [
    _CalEvent('Supermercado', -24.90, DateTime.now()),
    _CalEvent('Pago freelance', 150.00, DateTime.now()),
  ];

  // ---------- Navegación atajos ----------
  void _goByLabel(BuildContext context, String label) {
    switch (label) {
      case 'Gasto':
        Navigator.pushNamed(context, '/gastos');
        break;
      case 'Ingreso':
        // si ya tienes /ingresos úsalo; si no, puedes dirigir a /balance
        Navigator.pushNamed(context, '/balance');
        break;
      case 'Categorías':
        Navigator.pushNamed(context, '/categorias');
        break;
      case 'Reportes':
        Navigator.pushNamed(context, '/reportes');
        break;
      case 'Calendario':
        Navigator.pushNamed(context, '/calendario');
        break;
      case 'Notifs':
        Navigator.pushNamed(context, '/notifs');
        break;
      default:
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Ruta no definida: $label')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final header = '${_two(now.day)}/${_two(now.month)}/${now.year}';

    // Filtro simple: deudas cuyo vencimiento cae en el mes actual
    final monthDebts = _debts
        .where((d) => d.due.year == now.year && d.due.month == now.month)
        .toList();

    return Scaffold(
      backgroundColor: AppColors.bgSoft,
      appBar: AppBar(
        title: const Text('Calendario'),
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        actions: [
          IconButton(
            tooltip: 'Agregar deuda',
            onPressed: () => _showAddDebtSheet(context),
            icon: const Icon(Icons.add_card),
          ),
        ],
      ),

      // ---------------- CUERPO ----------------
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
        children: [
          // --- Tarjeta de Fecha + Acciones rápidas ---
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.05),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.event_available_outlined,
                      color: AppColors.ecoGreen,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Hoy • $header',
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        color: AppColors.textStrong,
                      ),
                    ),
                    const Spacer(),
                    _Pill(text: 'Mes actual'),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _goByLabel(context, 'Gasto'),
                        icon: const Icon(Icons.remove_circle_outline),
                        label: const Text('Gasto'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.danger,
                          side: const BorderSide(color: AppColors.danger),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _goByLabel(context, 'Ingreso'),
                        icon: const Icon(Icons.add_circle_outline),
                        label: const Text('Ingreso'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.ok,
                          side: const BorderSide(color: AppColors.ok),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _showAddDebtSheet(context),
                        icon: const Icon(Icons.credit_card),
                        label: const Text('Deuda'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFFB8860B),
                          side: const BorderSide(color: Color(0xFFB8860B)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // --- Eventos de hoy ---
          const Text(
            'Eventos de hoy',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: AppColors.textStrong,
            ),
          ),
          const SizedBox(height: 10),
          if (_today.isEmpty)
            const _EmptyInfo(text: 'No hay movimientos para hoy.')
          else
            for (final e in _today) ...[
              _EventTile(e: e),
              const SizedBox(height: 10),
            ],

          const SizedBox(height: 16),

          // --- Deudas de este mes ---
          Row(
            children: const [
              Icon(Icons.receipt_long_outlined, color: AppColors.ecoGreen),
              SizedBox(width: 8),
              Text(
                'Deudas de este mes',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: AppColors.textStrong,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (monthDebts.isEmpty)
            const _EmptyInfo(text: 'No tienes deudas que venzan este mes.')
          else
            for (final d in monthDebts) ...[
              _DebtTile(d: d),
              const SizedBox(height: 10),
            ],
        ],
      ),

      // ---------- FAB central con logo ----------
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _LogoFab(
        onTap: () => Navigator.pushNamedAndRemoveUntil(
          context,
          '/dashboard',
          (r) => false,
        ),
      ),

      // ---------- Barra inferior (Acciones rápidas) ----------
      bottomNavigationBar: _BottomActionsBar(
        left: const [
          _Action(icon: Icons.add, label: 'Gasto'),
          _Action(icon: Icons.show_chart_outlined, label: 'Ingreso'),
          _Action(icon: Icons.local_offer_outlined, label: 'Categorías'),
        ],
        right: const [
          _Action(icon: Icons.bar_chart_outlined, label: 'Reportes'),
          _Action(icon: Icons.calendar_today_outlined, label: 'Calendario'),
          _Action(icon: Icons.notifications_none, label: 'Notifs'),
        ],
        onPressed: (label) => _goByLabel(context, label),
      ),
    );
  }

  // ================== Bottom Sheet: Agregar Deuda ==================
  Future<void> _showAddDebtSheet(BuildContext context) async {
    final creditorCtrl = TextEditingController();
    final amountCtrl = TextEditingController();
    final noteCtrl = TextEditingController();

    DateTime start = DateTime.now();
    int months = 1;
    bool remind = true;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: 16 + MediaQuery.of(ctx).viewInsets.bottom,
          ),
          child: StatefulBuilder(
            builder: (ctx, setM) {
              final due = _addMonths(start, months);
              final monthsLabel = months == 1 ? '1 mes' : '$months meses';

              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: const [
                      Icon(Icons.add_card, color: AppColors.ecoGreen),
                      SizedBox(width: 8),
                      Text(
                        'Registrar deuda',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: AppColors.textStrong,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Acreedor
                  const Text(
                    'Acreedor',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: creditorCtrl,
                    decoration: _fieldInput('Banco, amigo, tienda…'),
                  ),
                  const SizedBox(height: 12),

                  // Monto
                  const Text(
                    'Monto',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: amountCtrl,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: _fieldInput('0.00'),
                  ),
                  const SizedBox(height: 12),

                  // Fecha inicio
                  const Text(
                    'Fecha de inicio',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 6),
                  InkWell(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: ctx,
                        initialDate: start,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) setM(() => start = picked);
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: _dateBox(start),
                  ),
                  const SizedBox(height: 12),

                  // Plazo (meses)
                  const Text(
                    'Plazo',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<int>(
                          value: months,
                          decoration: _fieldInput('Selecciona'),
                          items: List.generate(
                            24,
                            (i) => DropdownMenuItem(
                              value: i + 1,
                              child: Text('${i + 1}'),
                            ),
                          ),
                          onChanged: (v) => setM(() => months = v ?? 1),
                        ),
                      ),
                      const SizedBox(width: 10),
                      _Pill(text: monthsLabel),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Fecha de vencimiento calculada
                  const Text(
                    'Vence el',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 6),
                  _dateBox(due),
                  const SizedBox(height: 12),

                  // Nota
                  const Text(
                    'Nota (opcional)',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: noteCtrl,
                    maxLines: 2,
                    decoration: _fieldInput('Detalle o referencia'),
                  ),
                  const SizedBox(height: 12),

                  // Recordatorio
                  Row(
                    children: [
                      Switch(
                        value: remind,
                        onChanged: (v) => setM(() => remind = v),
                        activeColor: AppColors.ecoGreen,
                      ),
                      const SizedBox(width: 6),
                      const Text('Crear recordatorio de vencimiento'),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Guardar
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        final creditor = creditorCtrl.text.trim();
                        final amount =
                            double.tryParse(
                              amountCtrl.text.replaceAll(',', '.'),
                            ) ??
                            0.0;

                        if (creditor.isEmpty || amount <= 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Completa acreedor y un monto válido',
                              ),
                            ),
                          );
                          return;
                        }

                        setState(() {
                          _debts.add(
                            _Debt(
                              creditor: creditor,
                              amount: amount,
                              start: start,
                              months: months,
                              note: noteCtrl.text.trim(),
                              remind: remind,
                            ),
                          );
                        });

                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Deuda guardada: $creditor, \$${amount.toStringAsFixed(2)} • $monthsLabel',
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.save),
                      label: const Text('Guardar deuda'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.ecoGreen,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        textStyle: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  // =============== Helpers UI locales ===============
  String _two(int n) => n < 10 ? '0$n' : '$n';

  Widget _dateBox(DateTime d) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.event_outlined),
          const SizedBox(width: 8),
          Text(
            '${_two(d.day)}/${_two(d.month)}/${d.year}',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

// =============== MODELOS / WIDGETS REUTILIZABLES ===============
class _CalEvent {
  _CalEvent(this.title, this.amount, this.date);
  final String title;
  final double amount;
  final DateTime date;
}

class _EventTile extends StatelessWidget {
  const _EventTile({required this.e});
  final _CalEvent e;

  @override
  Widget build(BuildContext context) {
    final isNeg = e.amount < 0;
    final color = isNeg ? AppColors.danger : AppColors.ok;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  e.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.textStrong,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${e.date.hour.toString().padLeft(2, '0')}:${e.date.minute.toString().padLeft(2, '0')}',
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ),
          Text(
            (isNeg ? '-' : '+') + '\$${e.amount.abs().toStringAsFixed(2)}',
            style: TextStyle(fontWeight: FontWeight.w800, color: color),
          ),
        ],
      ),
    );
  }
}

class _EmptyInfo extends StatelessWidget {
  const _EmptyInfo({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.withOpacity(.2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: Colors.black45),
          const SizedBox(width: 10),
          Expanded(
            child: Text(text, style: const TextStyle(color: Colors.black54)),
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.text, this.color});
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.ecoGreen;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: c.withOpacity(.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: TextStyle(color: c, fontWeight: FontWeight.w700, fontSize: 12),
      ),
    );
  }
}

// =============== Deuda: modelo + tile ===============
class _Debt {
  _Debt({
    required this.creditor,
    required this.amount,
    required this.start,
    required this.months,
    required this.note,
    required this.remind,
  });

  final String creditor;
  final double amount;
  final DateTime start;
  final int months;
  final String note;
  final bool remind;

  DateTime get due => _addMonths(start, months);

  /// progreso del plazo [0..1]
  double get progress {
    final totalDays = due.difference(start).inDays;
    if (totalDays <= 0) return 1;
    final passed = DateTime.now().difference(start).inDays;
    return (passed / totalDays).clamp(0.0, 1.0);
  }

  int get daysLeft => due.difference(DateTime.now()).inDays;
}

class _DebtTile extends StatelessWidget {
  const _DebtTile({required this.d});
  final _Debt d;

  @override
  Widget build(BuildContext context) {
    final left = d.daysLeft;
    final lateSoon = left <= 3;
    final color = lateSoon ? AppColors.danger : AppColors.ecoGreen;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: color.withOpacity(.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.credit_card, size: 18, color: color),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      d.creditor,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        color: AppColors.textStrong,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        _Pill(
                          text:
                              'Plazo: ${d.months} ${d.months == 1 ? "mes" : "meses"}',
                          color: Colors.blueGrey,
                        ),
                        const SizedBox(width: 6),
                        _Pill(
                          text: left >= 0
                              ? 'Restan $left días'
                              : 'Vencida hace ${left.abs()} d',
                          color: lateSoon ? AppColors.danger : AppColors.ok,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                _money(d.amount, showSign: false),
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  color: AppColors.textStrong,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // barra de progreso del plazo
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 10,
              child: Stack(
                children: [
                  Container(color: Colors.grey.shade300),
                  FractionallySizedBox(
                    widthFactor: d.progress,
                    child: Container(color: color),
                  ),
                ],
              ),
            ),
          ),
          if (d.note.isNotEmpty) ...[
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                d.note,
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// =============== Utils compartidos ===============
DateTime _addMonths(DateTime base, int months) {
  // suma de meses conservando el día cuando sea posible
  final y = base.year;
  final m = base.month + months;
  final newYear = y + ((m - 1) ~/ 12);
  final newMonth = ((m - 1) % 12) + 1;
  final day = base.day;
  final lastDay = _lastDayOfMonth(newYear, newMonth);
  return DateTime(newYear, newMonth, day > lastDay ? lastDay : day);
}

int _lastDayOfMonth(int y, int m) {
  final firstDayNextMonth = (m == 12)
      ? DateTime(y + 1, 1, 1)
      : DateTime(y, m + 1, 1);
  return firstDayNextMonth.subtract(const Duration(days: 1)).day;
}

InputDecoration _fieldInput(String hint) => InputDecoration(
  hintText: hint,
  filled: true,
  fillColor: Colors.grey[200],
  isDense: true,
  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide.none,
  ),
);

// -------- NOTIFICACIONES --------
// -------- NOTIFICACIONES --------
// -------- NOTIFS --------
class NotifsScreen extends StatelessWidget {
  const NotifsScreen({super.key});

  void _goByLabel(BuildContext context, String label) {
    switch (label) {
      case 'Gasto':
        Navigator.pushNamed(context, '/gastos');
        break;
      case 'Ingreso': // tu intención: "Ingreso" abre balance
        Navigator.pushNamed(context, '/balance');
        break;
      case 'Categorías':
        Navigator.pushNamed(context, '/categorias');
        break;
      case 'Reportes':
        Navigator.pushNamed(context, '/reportes');
        break;
      case 'Calendario':
        Navigator.pushNamed(context, '/calendario');
        break;
      case 'Notifs':
        Navigator.pushNamed(context, '/notifs');
        break;
      default:
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Ruta no definida: $label')));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Modelo con ruta de destino por notificación
    final upcoming = <_Notif>[
      _Notif(
        icon: Icons.event_available_outlined,
        title: 'Pago de tarjeta',
        subtitle: 'Vence en 3 días • 450.00',
        tint: const Color(0xFFB59B0A),
        when: 'En 3 días',
        route: '/calendario',
      ),
      _Notif(
        icon: Icons.error_outline,
        title: 'Presupuesto de Alimentación',
        subtitle: 'Vas al 78% del límite',
        tint: Colors.redAccent,
        when: 'Hoy',
        route: '/reportes',
      ),
      _Notif(
        icon: Icons.savings_outlined,
        title: 'Meta de ahorro',
        subtitle: '¡A 200 de completar el mes!',
        tint: AppColors.ecoGreen,
        when: 'Esta semana',
        route: '/ahorros',
      ),
    ];

    final past = <_Notif>[
      _Notif(
        icon: Icons.receipt_long_outlined,
        title: 'Suscripción Netflix',
        subtitle: '-\$12.99 procesado',
        tint: const Color(0xFF2D9CDB),
        when: 'Ayer',
        read: true,
        route: '/gastos',
      ),
      _Notif(
        icon: Icons.check_circle_outline,
        title: 'Ingreso: salario',
        subtitle: '+\$2,500 recibido',
        tint: AppColors.ok,
        when: 'Hace 3 días',
        read: true,
        route: '/balance',
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.bgSoft,
      appBar: AppBar(
        title: const Text('Notificaciones'),
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),

      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
        children: [
          _QuickActionsBar(
            onMarkAllRead: () {
              // Devuelve 0 al dashboard para limpiar el badge (si lo esperas con await)
              Navigator.pop(context, 0);
            },
            onMute: () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Notificaciones silenciadas por 24h'),
              ),
            ),
            onSettings: () => Navigator.pushNamed(context, '/calendario'),
          ),
          const SizedBox(height: 16),

          _SectionCard(
            title: 'Próximas',
            children: [
              for (final n in upcoming)
                _NotifTile(
                  n,
                  onTap: () {
                    if (n.route != null) Navigator.pushNamed(context, n.route!);
                  },
                ),
            ],
          ),
          const SizedBox(height: 16),

          _SectionCard(
            title: 'Recientes',
            children: [
              for (final n in past)
                _NotifTile(
                  n,
                  onTap: () {
                    if (n.route != null) Navigator.pushNamed(context, n.route!);
                  },
                ),
            ],
          ),
          const SizedBox(height: 16),

          _CTARecordatorio(
            onCreate: () => Navigator.pushNamed(context, '/calendario'),
          ),
        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _LogoFab(
        onTap: () => Navigator.pushNamedAndRemoveUntil(
          context,
          '/dashboard',
          (r) => false,
        ),
      ),

      bottomNavigationBar: _BottomActionsBar(
        left: const [
          _Action(icon: Icons.add, label: 'Gasto'),
          _Action(icon: Icons.show_chart_outlined, label: 'Ingreso'),
          _Action(icon: Icons.local_offer_outlined, label: 'Categorías'),
        ],
        right: const [
          _Action(icon: Icons.bar_chart_outlined, label: 'Reportes'),
          _Action(icon: Icons.calendar_today_outlined, label: 'Calendario'),
          _Action(icon: Icons.notifications_none, label: 'Notifs'),
        ],
        onPressed: (label) => _goByLabel(context, label),
      ),
    );
  }
}

/// ======= MODELO SIMPLE =======
class _Notif {
  _Notif({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.tint,
    required this.when,
    this.read = false,
    this.route,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color tint;
  final String when;
  final bool read;
  final String? route; // ruta a la que navega al tocar
}

/// ======= UI WIDGETS =======
class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.children});
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.notifications_active_outlined,
                color: AppColors.ecoGreen,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  color: AppColors.textStrong,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...children.expand((w) => [w, const SizedBox(height: 8)]).toList()
            ..removeLast(),
        ],
      ),
    );
  }
}

class _NotifTile extends StatelessWidget {
  const _NotifTile(this.n, {required this.onTap});
  final _Notif n;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bg = n.read ? Colors.grey.shade50 : Colors.white;
    final badge = Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: n.read ? Colors.transparent : AppColors.ecoGreen,
      ),
    );

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: n.tint.withOpacity(.12),
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Icon(n.icon, color: n.tint),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    n.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.textStrong,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    n.subtitle,
                    style: const TextStyle(color: Colors.black87, fontSize: 13),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    n.when,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            badge,
          ],
        ),
      ),
    );
  }
}

class _QuickActionsBar extends StatelessWidget {
  const _QuickActionsBar({
    required this.onMarkAllRead,
    required this.onMute,
    required this.onSettings,
  });

  final VoidCallback onMarkAllRead;
  final VoidCallback onMute;
  final VoidCallback onSettings;

  @override
  Widget build(BuildContext context) {
    Widget btn(IconData icon, String text, VoidCallback onTap) =>
        OutlinedButton.icon(
          onPressed: onTap,
          icon: Icon(icon),
          label: Text(text),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.ecoGreenDark,
            side: BorderSide(color: AppColors.ecoGreen.withOpacity(.6)),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        btn(Icons.mark_email_read_outlined, 'Marcar todo leído', onMarkAllRead),
        btn(Icons.notifications_off_outlined, 'Silenciar 24h', onMute),
        btn(Icons.settings_outlined, 'Ajustes', onSettings),
      ],
    );
  }
}

class _CTARecordatorio extends StatelessWidget {
  const _CTARecordatorio({required this.onCreate});
  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6EF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFCADDCB)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.tips_and_updates_outlined,
            color: AppColors.ecoGreen,
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              'Crea recordatorios de pagos o metas y recibe avisos a tiempo.',
              style: TextStyle(color: Colors.black87),
            ),
          ),
          const SizedBox(width: 8),
          TextButton(onPressed: onCreate, child: const Text('Crear')),
        ],
      ),
    );
  }
}
