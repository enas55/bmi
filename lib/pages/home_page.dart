import 'dart:math';

import 'package:bmi_app/pages/result_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  bool isMale = true;
  double result = 0;
  int weight = 0;
  double height = 0;
  int age = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Body Mass Index',
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    genderType(context, type: 'male'),
                    const SizedBox(
                      width: 15,
                    ),
                    genderType(
                      context,
                      type: 'female',
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Container(
                  // margin: const EdgeInsets.symmetric(
                  //   horizontal: 20,
                  // ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blueGrey,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Height',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              color: Colors.black,
                            ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            height.toStringAsFixed(2),
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const Text(
                            'CM',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                            ),
                          )
                        ],
                      ),
                      Slider(
                          activeColor: Colors.teal,
                          inactiveColor: Colors.grey,
                          min: 0,
                          max: 300,
                          value: height,
                          onChanged: (value) {
                            height = value;
                            setState(() {});
                          })
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    weightAndAge(context, type: 'weight'),
                    const SizedBox(
                      width: 15,
                    ),
                    weightAndAge(context, type: 'age'),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height / 16,
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  var result = weight / pow(2, height / 100);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ResultPage(
                          result: result,
                          isMale: isMale,
                          age: age,
                        );
                      },
                    ),
                  );
                },
                child: const Text('Calculate'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Expanded genderType(BuildContext context, {required String type}) {
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => isMale = (type == 'male') ? true : false),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: (isMale && type == 'male') || (!isMale && type == 'female')
                ? Colors.teal
                : Colors.blueGrey,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                (type == 'male') ? Icons.male_outlined : Icons.female_outlined,
                size: 90,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                type == 'male' ? 'Male' : 'Female',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.black,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded weightAndAge(BuildContext context, {required String type}) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blueGrey,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              type == 'weight' ? 'Weight' : 'Age',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Colors.black,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              type == 'weight' ? '$weight' : '$age',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  mini: true,
                  heroTag: type == 'weight' ? 'weight--' : 'age--',
                  onPressed: () {
                    setState(
                      () {
                        // type == 'weight' ? weight-- : age--;
                        if (type == 'weight' && weight > 0) {
                          weight--;
                        } else if (type == 'age' && age > 0) {
                          age--;
                        }
                      },
                    );
                  },
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(
                  width: 5,
                ),
                FloatingActionButton(
                  mini: true,
                  heroTag: type == 'weight' ? 'weight++' : 'weight--',
                  onPressed: () {
                    setState(() {
                      type == 'weight' ? weight++ : age++;
                    });
                  },
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
