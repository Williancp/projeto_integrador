import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projeto_integrador/models/propriedade.dart';
import 'package:projeto_integrador/providers/cultivo_provider.dart';
import 'package:projeto_integrador/theme/app_theme.dart';

class CultivoListScreen extends StatefulWidget {
  final Propriedade propriedade;

  const CultivoListScreen({
    Key? key,
    required this.propriedade,
  }) : super(key: key);

  @override
  State<CultivoListScreen> createState() => _CultivoListScreenState();
}

class _CultivoListScreenState extends State<CultivoListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CultivoProvider>().loadCultivosByPropriedade(
          widget.propriedade.idPropriedade!,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cultivos - ${widget.propriedade.nome}'),
        elevation: 0,
      ),
      body: Consumer<CultivoProvider>(
        builder: (context, cultivoProvider, _) {
          if (cultivoProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (cultivoProvider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                  const SizedBox(height: 16),
                  Text(cultivoProvider.error!),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      context.read<CultivoProvider>().loadCultivosByPropriedade(
                            widget.propriedade.idPropriedade!,
                          );
                    },
                    child: const Text('Tentar Novamente'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: cultivoProvider.cultivos.length + 1,
            itemBuilder: (context, index) {
              if (index == cultivoProvider.cultivos.length) {
                return Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        '/cultivo/create',
                        arguments: widget.propriedade,
                      );
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Adicionar Cultivo'),
                  ),
                );
              }

              final cultivo = cultivoProvider.cultivos[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ExpansionTile(
                  title: Text(cultivo.cultura),
                  subtitle: Text(cultivo.canalVenda),
                  leading: Icon(
                    Icons.agriculture,
                    color: AppTheme.primaryGreen,
                  ),
                  trailing: PopupMenuButton(
                    itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                      PopupMenuItem(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            '/cultivo/edit',
                            arguments: cultivo,
                          );
                        },
                        child: const Row(
                          children: [
                            Icon(Icons.edit, size: 18),
                            SizedBox(width: 8),
                            Text('Editar'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        onTap: () {
                          _showDeleteConfirmation(context, cultivo.idCultivo!);
                        },
                        child: const Row(
                          children: [
                            Icon(Icons.delete, size: 18, color: AppTheme.primaryRed),
                            SizedBox(width: 8),
                            Text('Deletar', style: TextStyle(color: AppTheme.primaryRed)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDetailRow('Cultura', cultivo.cultura),
                          _buildDetailRow('Canal de Venda', cultivo.canalVenda),
                          if (cultivo.percentualReceita != null)
                            _buildDetailRow(
                              '% sobre Receita',
                              '${cultivo.percentualReceita}%',
                            ),
                          if (cultivo.anoImplantacao != null)
                            _buildDetailRow(
                              'Ano de Implantação',
                              '${cultivo.anoImplantacao}',
                            ),
                          if (cultivo.numeroPlantas != null)
                            _buildDetailRow(
                              'Número de Plantas',
                              '${cultivo.numeroPlantas}',
                            ),
                          if (cultivo.percentualVendaCanal != null)
                            _buildDetailRow(
                              '% Venda pelo Canal',
                              '${cultivo.percentualVendaCanal}%',
                            ),
                          if (cultivo.numeroPontosVenda != null)
                            _buildDetailRow(
                              'Pontos de Venda',
                              '${cultivo.numeroPontosVenda}',
                            ),
                          if (cultivo.distanciaEntrega != null)
                            _buildDetailRow(
                              'Distância de Entrega',
                              '${cultivo.distanciaEntrega} km',
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Exclusão'),
          content: const Text('Tem certeza que deseja deletar este cultivo?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                context.read<CultivoProvider>().deleteCultivo(id);
                Navigator.pop(context);
              },
              child: const Text('Deletar', style: TextStyle(color: AppTheme.primaryRed)),
            ),
          ],
        );
      },
    );
  }
}
