import 'package:flutter/material.dart';

import '../../../../domain/user_requests/entity/user_requests.dart';

class RequestFieldCardAdmin extends StatelessWidget {
  final UserRequests request;
  final VoidCallback? onTap;
  final VoidCallback? onTapCancel;

  const RequestFieldCardAdmin(
      {super.key, required this.request, this.onTap, this.onTapCancel});
  @override
  Widget build(BuildContext context) {
    const subTitleStyle = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
    );
    const titleStyle = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
    );
    const subtitle = 'Solicitud de';
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.fromLTRB(15, 10, 25, 0),
            leading: const Icon(
              Icons.email,
              color: Color(0xff358aac),
              size: 20,
            ),
            title: Text('$subtitle: ${request.requestMadeBy}',
                style: subTitleStyle),
            subtitle: Text('Nombre del campo: ${request.requestTo}',
                style: titleStyle),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                child: const Text('Aceptar'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (contextD) {
                      return AlertDialog(
                        title: const Text('Confirmar solicitud'),
                        content: const Text('Confirma la solicitud'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(contextD),
                            child: const Text('CANCELAR'),
                          ),
                          TextButton(
                            onPressed: () {
                              onTap!();
                              Navigator.pop(contextD);
                            },
                            child: const Text('ACEPTAR'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              const SizedBox(width: 8),
              TextButton(
                child: const Text('Cancelar'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (contextD) {
                      return AlertDialog(
                        title: const Text('Cancelar solicitud'),
                        content: const Text('Confirma la cancelación'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(
                                contextD), //Navigator.pop(context),
                            child: const Text('CANCELAR'),
                          ),
                          TextButton(
                            onPressed: () {
                              onTapCancel!();
                              Navigator.pop(contextD);
                            },
                            child: const Text('ACEPTAR'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
