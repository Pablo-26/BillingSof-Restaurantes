import 'package:flutter/material.dart';
import 'package:whatsapp/whatsapp.dart';

class WhatsappNotify extends StatefulWidget {
  const WhatsappNotify({super.key});

  @override
  State<WhatsappNotify> createState() => _WhatsappNotifyState();
}

class _WhatsappNotifyState extends State<WhatsappNotify> {
  final accessToken =
      'EAAVlRYMD1KMBO4Rsdy06LZBlPJBEpjT5bW9s8a3W7cbwBHLg99miWjPe7pH5MvZBaFrQKT2gdwgskmosNw8CAm3huGqEP2H1vGSyqrMG7VGqrsiDaGfAb7lpYMpCwtDyxZBwKmA99gpLu36o892yJtTREsqRkBtj1oXMgLEruy4B3VvSIbREcU0P3HtU5OCZARXDFIRIR29D4AAcNgWu';
  final fromNumberId = '372192112647400';

  late WhatsApp whatsapp;

  @override
  void initState() {
    super.initState();
    whatsapp = WhatsApp(accessToken, fromNumberId);
  }

  Future<void> sendMessage() async {
    var res = await whatsapp.sendMessage(
      phoneNumber: '+593995731957', // Reemplaza 'PHONE_NUMBER' con el número de teléfono destino
      text: 'Mensaje de prueba de sistema', // Reemplaza 'text_message' con el mensaje de texto que deseas enviar
      previewUrl: true,
    );

    if (res.isSuccess()) {
      // cuando el mensaje se envía correctamente
      debugPrint('Message ID: ${res.getMessageId()}');
      debugPrint('Message sent to: ${res.getPhoneNumber()}');
      debugPrint('API Response: ${res.getResponse().toString()}');
    } else {
      // cuando algo sale mal
      debugPrint('HTTP Code: ${res.getHttpCode()}');
      debugPrint('API Error: ${res.getErrorMessage()}');
      debugPrint('Request Error: ${res.getError()}');
      debugPrint('API Response: ${res.getResponse().toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enviar Mensaje por WhatsApp'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: sendMessage,
          child: const Text('Enviar Mensaje'),
        ),
      ),
    );
  }
}