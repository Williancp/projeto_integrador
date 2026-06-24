import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:projeto_integrador/models/propriedade.dart';
import 'package:projeto_integrador/providers/auth_provider.dart';
import 'package:projeto_integrador/providers/propriedade_provider.dart';

class PropriedadeFormScreen extends StatefulWidget {
  final Propriedade? propriedade;
  final bool isEditing;

  const PropriedadeFormScreen({
    Key? key,
    this.propriedade,
    this.isEditing = false,
  }) : super(key: key);

  @override
  State<PropriedadeFormScreen> createState() => _PropriedadeFormScreenState();
}

class _PropriedadeFormScreenState extends State<PropriedadeFormScreen> {
  late TextEditingController _nomeController;
  late TextEditingController _localidadeController;
  late TextEditingController _cidadeController;
  late TextEditingController _telefoneController;
  late TextEditingController _areaTotalController;
  late TextEditingController _latitudeController;
  late TextEditingController _longitudeController;

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.propriedade?.nome ?? '');
    _localidadeController =
        TextEditingController(text: widget.propriedade?.localidade ?? '');
    _cidadeController =
        TextEditingController(text: widget.propriedade?.cidade ?? '');
    _telefoneController =
        TextEditingController(text: widget.propriedade?.telefone ?? '');
    _areaTotalController = TextEditingController(
      text: widget.propriedade?.areaTotal?.toString() ?? '',
    );
    _latitudeController = TextEditingController(
      text: widget.propriedade?.latitude?.toString() ?? '',
    );
    _longitudeController = TextEditingController(
      text: widget.propriedade?.longitude?.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _localidadeController.dispose();
    _cidadeController.dispose();
    _telefoneController.dispose();
    _areaTotalController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    super.dispose();
  }

  void _handleSave() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    final userId = context.read<AuthProvider>().user?.idUsuario ?? 0;
    final propriedade = Propriedade(
      idPropriedade: widget.propriedade?.idPropriedade,
      nome: _nomeController.text.trim(),
      localidade: _emptyToNull(_localidadeController.text),
      cidade: _emptyToNull(_cidadeController.text),
      telefone: _emptyToNull(_onlyDigits(_telefoneController.text)),
      areaTotal: _parseDoubleOptional(_areaTotalController.text),
      latitude: _parseDoubleOptional(_latitudeController.text),
      longitude: _parseDoubleOptional(_longitudeController.text),
      idUsuario: userId,
    );

    final provider = context.read<PropriedadeProvider>();
    final success = widget.isEditing
        ? await provider.updatePropriedade(propriedade) != null
        : await provider.createPropriedade(propriedade) != null;

    setState(() => _isLoading = false);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.isEditing
              ? 'Estabelecimento rural atualizado com sucesso'
              : 'Estabelecimento rural criado com sucesso'),
        ),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(provider.error ?? 'Erro ao salvar estabelecimento rural'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing
            ? 'Editar Estabelecimento Rural'
            : 'Adicionar Estabelecimento Rural'),
        backgroundColor: Colors.green[700],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(
                  labelText: 'Nome do Estabelecimento Rural *',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nome e obrigatorio';
                  }
                  if (value.trim().length < 3) {
                    return 'Informe pelo menos 3 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _localidadeController,
                decoration: InputDecoration(
                  labelText: 'Localidade',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _cidadeController,
                decoration: InputDecoration(
                  labelText: 'Cidade',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _telefoneController,
                decoration: InputDecoration(
                  labelText: 'Telefone',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9 ()+-]')),
                ],
                validator: _validateTelefoneOpcional,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _areaTotalController,
                decoration: InputDecoration(
                  labelText: 'Area Total (hectares)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9,.]')),
                ],
                validator: _validateDecimalPositivoOpcional,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _latitudeController,
                decoration: InputDecoration(
                  labelText: 'Latitude',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[-0-9,.]')),
                ],
                validator: _validateLatitudeOpcional,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _longitudeController,
                decoration: InputDecoration(
                  labelText: 'Longitude',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[-0-9,.]')),
                ],
                validator: _validateLongitudeOpcional,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleSave,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : Text(
                          widget.isEditing ? 'Atualizar' : 'Criar',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _emptyToNull(String value) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  String _onlyDigits(String value) {
    return value.replaceAll(RegExp(r'[^0-9]'), '');
  }

  double? _parseDoubleOptional(String value) {
    if (value.trim().isEmpty) {
      return null;
    }
    return double.tryParse(value.replaceAll(',', '.'));
  }

  String? _validateTelefoneOpcional(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    final digits = _onlyDigits(value);
    if (digits.length < 10 || digits.length > 11) {
      return 'Informe um telefone com DDD';
    }
    return null;
  }

  String? _validateDecimalPositivoOpcional(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    final parsed = double.tryParse(value.replaceAll(',', '.'));
    if (parsed == null || parsed <= 0) {
      return 'Informe um numero maior que zero';
    }
    return null;
  }

  String? _validateLatitudeOpcional(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    final parsed = double.tryParse(value.replaceAll(',', '.'));
    if (parsed == null || parsed < -90 || parsed > 90) {
      return 'Latitude deve ficar entre -90 e 90';
    }
    return null;
  }

  String? _validateLongitudeOpcional(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    final parsed = double.tryParse(value.replaceAll(',', '.'));
    if (parsed == null || parsed < -180 || parsed > 180) {
      return 'Longitude deve ficar entre -180 e 180';
    }
    return null;
  }
}
