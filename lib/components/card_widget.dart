import 'package:flutter/material.dart';

import '../data/responseData.dart';

class CardWidget extends StatelessWidget {
  final int prazo;
  final double valor;
  final bool isSelected;
  final VoidCallback onSelected;
  CardWidget({
    required this.prazo,
    required this.valor,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.18,
        height: MediaQuery.of(context).size.height * 0.4,
        child: Card(
          surfaceTintColor: Colors.white,
          margin: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color:  isSelected ? Colors.green : Colors.white,
              width: 3,
            ),
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Row(
                  children: [
                    Text(
                      "Disponível:",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                Text(
                  'R\$ ${valorLimiteData.toString()},00',
                  style: const TextStyle(fontSize: 20, color: Colors.green),
                ),
                const SizedBox(height: 10,),
                Container(
                  width: MediaQuery.of(context).size.width * 0.15,
                  height: 1,
                  color: Colors.grey.withOpacity(0.3),
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "${prazo.toString()}x",
                      style: const TextStyle(fontSize: 30),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Parcela:", style: TextStyle(fontSize: 10),),
                    Text("R\$ ${valor.toStringAsFixed(2)}", style: const TextStyle(fontSize: 12),),
                  ],
                ),
                const SizedBox(height: 15,),
                InkWell(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.04,
                    width: MediaQuery.of(context).size.width * 0.1,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.check_circle, color: Colors.white, size: 20,),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.015,),
                        const Text(
                          "Selecionar",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
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