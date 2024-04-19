import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NoWeatherBody extends StatelessWidget {
  const NoWeatherBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'there is no weather 😔 start',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width/14,
              ),
            ),
            Text(
              'searching now 🔍',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width/14,
              ),
            )
          ],
        ),
      ),
    );
  }
}
