import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:projeto_integrador/models/cultivo.dart';
import 'package:projeto_integrador/models/propriedade.dart';
import 'package:projeto_integrador/providers/cultivo_provider.dart';

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
  late TextEditingController _percentualReceitaController;
  late TextEditingController _anoImplantacaoController;
  late TextEditingController _numeroPlantasController;
  late TextEditingController _numeroPontosVendaController;
  late TextEditingController _distanciaEntregaController;
  late int _idPropriedade;

  final _formKey = GlobalKey<FormState>();
  final List<_CanalVendaFormItem> _canaisVenda = [];

  final List<String> _culturas = [
    'Maca',
    'Pera',
    'Pessego',
    'Morango',
    'Framboesa',
    'Uva',
    'Laranja',
    'Limao',
    'Abacaxi',
    'Banana',
  ];

  final List<String> _canaisVendaOpcoes = [
    'Feira',
    'Supermercado',
    'Merenda Escolar',
    'Mercado',
    'Direto ao Consumidor',
    'Cooperativa',
    'Exportacao',
  ];

  @override
  void initState() {
    super.initState();
    _culturaController = TextEditingController(text: widget.cultivo?.cultura ?? '');
    _percentualReceitaController = TextEditingController(
      text: widget.cultivo?.percentualReceita?.toString() ?? '',
    );
    _anoImplantacaoController = TextEditingController(
      text: widget.cultivo?.anoImplantacao?.toString() ?? '',
    );
    _numeroPlantasController = TextEditingController(
      text: widget.cultivo?.numeroPlantas?.toString() ?? '',
    );
    _numeroPontosVendaController = TextEditingController(
      text: widget.cultivo?.numeroPontosVenda?.toString() ?? '',
    );
    _distanciaEntregaController = TextEditingController(
      text: widget.cultivo?.distanciaEntrega?.toString() ?? '',
    );
    _idPropriedade = widget.cultivo?.idPropriedade ?? widget.propriedade!.idPropriedade!;
    _inicializarCanaisVenda();
  }

  @override
  void dispose() {
    _culturaController.dispose();
    _percentualReceitaController.dispose();
    _anoImplantacaoController.dispose();
    _numeroPlantasController.dispose();
    _numeroPontosVendaController.dispose();
    _distanciaEntregaController.dispose();
    for (final canal in _canaisVenda) {
      canal.dispose();
    }
    super.dispose();
  }

  void _inicializarCanaisVenda() {
    final cultivo = widget.cultivo;
    if (cultivo != null && cultivo.canaisVenda.isNotEmpty) {
      for (final canal in cultivo.canaisVenda) {
        _canaisVenda.add(
          _CanalVendaFormItem(
            canalVenda: canal.canalVenda,
            percentualVenda: canal.percentualVenda.toString(),
          ),
        );
      }
      return;
    }

    _canaisVenda.add(
      _CanalVendaFormItem(
        canalVenda: cultivo?.canalVenda ?? '',
        percentualVenda: cultivo?.percentualVendaCanal?.toString() ?? '100',
      ),
    );
  }

  double get _totalPercentualCanais {
    return _canaisVenda.fold(0.0, (total, canal) {
      final value = canal.percentualController.text.replaceAll(',', '.');
      return total + (double.tryParse(value) ?? 0);
    });
  }

  void _adicionarCanalVenda() {
    setState(() {
      _canaisVenda.add(_CanalVendaFormItem());
    });
  }

  void _removerCanalVenda(int index) {
    if (_canaisVenda.length == 1) {
      return;
    }

    setState(() {
      final canal = _canaisVenda.removeAt(index);
      canal.dispose();
    });
  }

  void _handleSave() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_totalPercentualCanais > 100) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('A soma dos canais de venda nao pode passar de 100%.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final canaisVenda = _canaisVenda
        .map(
          (canal) => CanalVenda(
            canalVenda: canal.canalController.text.trim(),
            percentualVenda: double.parse(
              canal.percentualController.text.replaceAll(',', '.'),
            ),
          ),
        )
        .toList();
    final resumoCanais = canaisVenda
        .map((canal) => '${canal.canalVenda} (${canal.percentualVenda}%)')
        .join(', ');

    final cultivo = Cultivo(
      idCultivo: widget.cultivo?.idCultivo,
      idPropriedade: _idPropriedade,
      cultura: _culturaController.text,
      canalVenda: resumoCanais,
      canaisVenda: canaisVenda,
      percentualReceita: _parseDoubleOptional(_percentualReceitaController.text),
      anoImplantacao: _parseIntOptional(_anoImplantacaoController.text),
      numeroPlantas: _parseIntOptional(_numeroPlantasController.text),
      percentualVendaCanal: _totalPercentualCanais,
      numeroPontosVenda: _parseIntOptional(_numeroPontosVendaController.text),
      distanciaEntrega: _parseDoubleOptional(_distanciaEntregaController.text),
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
                    'Informacoes do Cultivo',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _culturas.contains(_culturaController.text)
                        ? _culturaController.text
                        : null,
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
                        return 'Cultura obrigatoria';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildCanaisVendaSection(),
                  _buildDecimalField(
                    controller: _percentualReceitaController,
                    label: '% sobre Receita',
                    icon: Icons.percent,
                    suffix: '%',
                    validator: _validatePercentualOpcional,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _anoImplantacaoController,
                    decoration: const InputDecoration(
                      labelText: 'Ano de Implantacao',
                      prefixIcon: Icon(Icons.calendar_today),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: _validateAnoOpcional,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _numeroPlantasController,
                    decoration: const InputDecoration(
                      labelText: 'Numero de Plantas',
                      prefixIcon: Icon(Icons.grass),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: _validateInteiroPositivoOpcional,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _numeroPontosVendaController,
                    decoration: const InputDecoration(
                      labelText: 'Pontos de Venda',
                      prefixIcon: Icon(Icons.location_on),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: _validateInteiroPositivoOpcional,
                  ),
                  const SizedBox(height: 16),
                  _buildDecimalField(
                    controller: _distanciaEntregaController,
                    label: 'Distancia de Entrega (km)',
                    icon: Icons.directions_car,
                    validator: _validateDecimalPositivoOpcional,
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

  Widget _buildCanaisVendaSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Canais de Venda',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextButton.icon(
              onPressed: _adicionarCanalVenda,
              icon: const Icon(Icons.add),
              label: const Text('Adicionar'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...List.generate(_canaisVenda.length, (index) {
          final item = _canaisVenda[index];
          final selected = _canaisVendaOpcoes.contains(item.canalController.text)
              ? item.canalController.text
              : null;

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  value: selected,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: 'Canal',
                    prefixIcon: Icon(Icons.store),
                  ),
                  items: _canaisVendaOpcoes.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      item.canalController.text = newValue ?? '';
                    });
                  },
                  validator: (value) {
                    if ((value == null || value.isEmpty) &&
                        item.canalController.text.trim().isEmpty) {
                      return 'Obrigatorio';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: item.percentualController,
                        decoration: const InputDecoration(
                          labelText: '% venda',
                          suffixText: '%',
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9,.]')),
                        ],
                        onChanged: (_) => setState(() {}),
                        validator: (value) {
                          final parsed =
                              double.tryParse((value ?? '').replaceAll(',', '.'));
                          if (parsed == null) {
                            return 'Obrigatorio';
                          }
                          if (parsed <= 0 || parsed > 100) {
                            return '0 a 100';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      tooltip: 'Remover canal',
                      onPressed: _canaisVenda.length == 1
                          ? null
                          : () => _removerCanalVenda(index),
                      icon: const Icon(Icons.delete_outline),
                      color: Colors.red,
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
        Text(
          'Total: ${_totalPercentualCanais.toStringAsFixed(1)}%',
          style: TextStyle(
            color: _totalPercentualCanais > 100 ? Colors.red : Colors.green[700],
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDecimalField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String? Function(String?) validator,
    String? suffix,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        suffixText: suffix,
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9,.]')),
      ],
      validator: validator,
    );
  }

  double? _parseDoubleOptional(String value) {
    if (value.trim().isEmpty) {
      return null;
    }
    return double.tryParse(value.replaceAll(',', '.'));
  }

  int? _parseIntOptional(String value) {
    if (value.trim().isEmpty) {
      return null;
    }
    return int.tryParse(value);
  }

  String? _validatePercentualOpcional(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    final parsed = double.tryParse(value.replaceAll(',', '.'));
    if (parsed == null || parsed < 0 || parsed > 100) {
      return 'Informe um percentual entre 0 e 100';
    }
    return null;
  }

  String? _validateDecimalPositivoOpcional(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    final parsed = double.tryParse(value.replaceAll(',', '.'));
    if (parsed == null || parsed < 0) {
      return 'Informe um numero valido';
    }
    return null;
  }

  String? _validateInteiroPositivoOpcional(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    final parsed = int.tryParse(value);
    if (parsed == null || parsed < 0) {
      return 'Informe um numero valido';
    }
    return null;
  }

  String? _validateAnoOpcional(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    final parsed = int.tryParse(value);
    if (parsed == null || parsed < 1900 || parsed > DateTime.now().year) {
      return 'Informe um ano valido';
    }
    return null;
  }
}

class _CanalVendaFormItem {
  final TextEditingController canalController;
  final TextEditingController percentualController;

  _CanalVendaFormItem({
    String canalVenda = '',
    String percentualVenda = '',
  })  : canalController = TextEditingController(text: canalVenda),
        percentualController = TextEditingController(text: percentualVenda);

  void dispose() {
    canalController.dispose();
    percentualController.dispose();
  }
}


