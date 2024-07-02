import 'package:flutter/material.dart';

class DropButton extends StatefulWidget {
  const DropButton({super.key});

  @override
  State<DropButton> createState() => _DropButtonState();
}

class _DropButtonState extends State<DropButton> {
  @override
  Widget build(BuildContext context) {
    return  DropdownButton<String>(
      items: [
        DropdownMenuItem<String>(
          value: 'jazz',
          child: Text('Jazz',style: Theme.of(context).textTheme!.headlineSmall!.copyWith(color: Colors.black),),
        ),
        DropdownMenuItem<String>(
          value: 'telenor',
          child: Text('Telenor',style: Theme.of(context).textTheme!.headlineSmall!.copyWith(color: Colors.black),),
        ),
        DropdownMenuItem<String>(
          value: 'zong',
          child: Text('Zong',style: Theme.of(context).textTheme!.headlineSmall!.copyWith(color: Colors.black),),
        ),
        DropdownMenuItem<String>(
          value: 'ufone',
          child: Text('Ufone',style: Theme.of(context).textTheme!.headlineSmall!.copyWith(color: Colors.black),),
        ),
        DropdownMenuItem<String>(
          value: 'other',
          child: Text('Other',style: Theme.of(context).textTheme!.headlineSmall!.copyWith(color: Colors.black),),
        ),
      ],
      onChanged: (String? value) {
        // Implement your onChanged logic here
        // Typically, you would set a state variable to hold the selected value

      },
    );
  }
}
