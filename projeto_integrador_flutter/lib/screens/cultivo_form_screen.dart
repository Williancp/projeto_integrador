import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projeto_integrador/models/cultivo.dart';
import 'package:projeto_integrador/models/propriedade.dart';
import 'package:projeto_integrador/providers/cultivo_provider.dart';
import 'package:projeto_integrador/theme/app_theme.dart';

class CultivoFormScreen extends StatefulWidget {
  final Propriedade? propriedade;
  final Cultivo? cultivo;
  final bool isEditing;

  const CultivoFormScreen({
    Key? key,
    this.propriedade,
    this.cultivo,
    this.isEditing = false,
  }) : super(key: key);

  @override
  State<CultivoFormScreen> createState() => _CultivoFormScreenState();
}

class _CultivoFormScreenState extends State<CultivoFormScreen> {
  late TextEditingController _culturaController;
  late TextEditingController _canalVendaController;
  late TextEditingController _percentualReceitaController;
  late TextEditingController _anoImplantacaoController;
  late TextEditingController _numeroPlantasController;
  late TextEditingController _percentualVendaCanalController;
  late TextEditingController _numeroPontosVendaController;
  late TextEditingController _distanciaEntregaController;
  late int _idPropriedade;
  final _formKey = GlobalKey<FormState>();

  final List<String> _culturas = [
    'Maçã',
    'Pera',
    'Pêssego',
    'Morango',
    'Framboesa',
    'Uva',
    'Laranja',
    'Limão',
    'Abacaxi',
    'Banana',
  ];

  final List<String> _canaisVenda = [
    'Mercado',
    'Feira',
    'Direto ao Consumidor',
    'Cooperativa',
    'Exportação',
  ];

  @override
  void initState() {
    super.initState();
    _culturaController = TextEditingController(text: widget.cultivo?.cultura ?? '');
    _canalVendaController = TextEditingController(text: widget.cultivo?.canalVenda ?? '');
    _percentualReceitaController = TextEditingController(
      text: widget.cultivo?.percentualReceita?.toString() ?? '',
    );
    _anoImplantacaoController = TextEditingController(
      text: widget.cultivo?.anoImplantacao?.toString() ?? '',
    );
    _numeroPlantasController = TextEditingController(
      text: widget.cultivo?.numeroPlantas?.toString() ?? '',
    );
    _percentualVendaCanalController = TextEditingController(
      text: widget.cultivo?.percentualVendaCanal?.toString() ?? '',
    );
    _numeroPontosVendaController = TextEditingController(
      text: widget.cultivo?.numeroPontosVenda?.toString() ?? '',
    );
    _distanciaEntregaController = TextEditingController(
      text: widget.cultivo?.distanciaEntrega?.toString() ?? '',
    );
    _idPropriedade = widget.cultivo?.idPropriedade ?? widget.propriedade!.idPropriedade!;
  }

  @override
  void dispose() {
    _culturaController.dispose();
    _canalVendaController.dispose();
    _percentualReceitaController.dispose();
    _anoImplantacaoController.dispose();
    _numeroPlantasController.dispose();
    _percentualVendaCanalController.dispose();
    _numeroPontosVendaController.dispose();
    _distanciaEntregaController.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (_formKey.currentState!.validate()) {
      final cultivo = Cultivo(
        idCultivo: widget.cultivo?.idCultivo,
        idPropriedade: _idPropriedade,
        cultura: _culturaController.text,
        canalVenda: _canalVendaController.text,
        percentualReceita: _percentualReceitaController.text.isNotEmpty
            ? double.parse(_percentualReceitaController.text)
            : null,
        anoImplantacao: _anoImplantacaoController.text.isNotEmpty
            ? int.parse(_anoImplantacaoController.text)
            : null,
        numeroPlantas: _numeroPlantasController.text.isNotEmpty
            ? int.parse(_numeroPlantasController.text)
            : null,
        percentualVendaCanal: _percentualVendaCanalController.text.isNotEmpty
            ? double.parse(_percentualVendaCanalController.text)
            : null,
        numeroPontosVenda: _numeroPontosVendaController.text.isNotEmpty
            ? int.parse(_numeroPontosVendaController.text)
            : null,
        distanciaEntrega: _distanciaEntregaController.text.isNotEmpty
            ? double.parse(_distanciaEntregaController.text)
            : null,
      );

      if (widget.isEditing && widget.cultivo != null) {
        context.read<CultivoProvider>().updateCultivo(
              widget.cultivo!.idCultivo!,
              cultivo,
            );
      } else {
        context.read<CultivoProvider>().createCultivo(cultivo);
      }

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? 'Editar Cultivo' : 'Novo Cultivo'),
        elevation: 0,
      ),
      body: Consumer<CultivoProvider>(
        builder: (context, cultivoProvider, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Informações do Cultivo',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _culturaController.text.isNotEmpty ? _culturaController.text : null,
                    decoration: const InputDecoration(
                      labelText: 'Cultura',
                      prefixIcon: Icon(Icons.agriculture),
                    ),
                    items: _culturas.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _culturaController.text = newValue ?? '';
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Cultura é obrigatória';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _canalVendaController.text.isNotEmpty ? _canalVendaController.text : null,
                    decoration: const InputDecoration(
                      labelText: 'Canal de Venda',
                      prefixIcon: Icon(Icons.store),
                    ),
                    items: _canaisVenda.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _canalVendaController.text = newValue ?? '';
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Canal de Venda é obrigatório';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _percentualReceitaController,
                    decoration: const InputDecoration(
                      labelText: '% sobre Receita',
                      prefixIcon: Icon(Icons.percent),
                      suffixText: '%',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _anoImplantacaoController,
                    decoration: const InputDecoration(
                      labelText: 'Ano de Implantação',
                      prefixIcon: Icon(Icons.calendar_today),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _numeroPlantasController,
                    decoration: const InputDecoration(
                      labelText: 'Número de Plantas',
                      prefixIcon: Icon(Icons.grass),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _percentualVendaCanalController,
                    decoration: const InputDecoration(
                      labelText: '% Venda pelo Canal',
                      prefixIcon: Icon(Icons.percent),
                      suffixText: '%',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _numeroPontosVendaController,
                    decoration: const InputDecoration(
                      labelText: 'Pontos de Venda',
                      prefixIcon: Icon(Icons.location_on),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _distanciaEntregaController,
                    decoration: const InputDecoration(
                      labelText: 'Distância de Entrega (km)',
                      prefixIcon: Icon(Icons.directions_car),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 32),
                  if (cultivoProvider.error != null)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        cultivoProvider.error!,
                        style: TextStyle(color: Colors.red[700]),
                      ),
                    ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancelar'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: cultivoProvider.isLoading ? null : _handleSave,
                          child: cultivoProvider.isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              : const Text('Salvar'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
