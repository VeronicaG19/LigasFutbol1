/*class DurationTimeInput extends StatelessWidget {
  const DurationTimeInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeeCubit, FeeState>(
      buildWhen: (previous, current) =>
          previous.durationTimeValidator != current.durationTimeValidator,
      builder: (context, state) {
        return TextFormField(
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          maxLength: 30,
          onChanged: (value) =>
              context.read<FeeCubit>().onDurationTimeChange(duration: value),
          decoration: InputDecoration(
            labelText: "Duración : ",
            labelStyle: const TextStyle(fontSize: 13),
            errorText:
                state.durationTimeValidator.invalid ? "Marca el tiempo" : null,
          ),
          style: const TextStyle(fontSize: 13),
        );
      },
    );
  }
}*/
