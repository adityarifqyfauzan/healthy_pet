import 'package:flutter/material.dart';
import 'package:healthy_pet/models/doctor_model.dart';
import 'package:healthy_pet/models/service_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

var menus = [
  FeatherIcons.home,
  FeatherIcons.heart,
  FeatherIcons.messageCircle,
  FeatherIcons.user
];

var selectedMenu = 1;

class _HomeScreenState extends State<HomeScreen> {
  var selectedService = 0;
  var serviceName = "";
  var selectedDoctor = "";
  var doctorLen = 0;

  void selectService(int index, String name) {
    setState(() {
      selectedService = index;
      serviceName = name;
    });
  }

  void selectDoctor(String name) {
    setState(() {
      selectedDoctor = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      bottomNavigationBar: _bottomNavBar(),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 22,
            ),
            _greeting(),
            const SizedBox(
              height: 17,
            ),
            _card(),
            const SizedBox(
              height: 21,
            ),
            _search(),
            const SizedBox(
              height: 20,
            ),
            _services(),
            const SizedBox(
              height: 27.6,
            ),
            _doctors()
          ],
        ),
      )),
    );
  }

  BottomNavigationBar _bottomNavBar() {
    return BottomNavigationBar(
      items: menus
          .map((e) =>
              BottomNavigationBarItem(icon: Icon(e), label: e.toString()))
          .toList(),
      showSelectedLabels: false,
      selectedItemColor: const Color(0xFF818AF9),
      unselectedItemColor: const Color(0xFFBFBFBF),
    );
  }

  ListView _doctors() {
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) =>
          _doctor(doctors[index])
        ,
        separatorBuilder: (context, index) => const SizedBox(
              height: 11,
            ),
        itemCount: doctors.length);
  }

  InkWell _doctor(DoctorModel doctorModel) {
    return InkWell(
      onTap: () {
        selectDoctor(doctorModel.name);
      },
      radius: 100,
      borderRadius: BorderRadius.circular(14),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                    color: const Color(0xFF35385A).withOpacity(.12),
                    blurRadius: 30,
                    offset: const Offset(0, 2))
              ]),
          child: Row(
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                child: Image.asset(
                  "assets/images/${doctorModel.image}",
                  width: 88,
                  height: 103,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctorModel.name,
                      style: GoogleFonts.manrope(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF3F3E3F)),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    RichText(
                        text: TextSpan(
                            text: "Service: ${doctorModel.services.join(', ')}",
                            style: GoogleFonts.manrope(
                                fontSize: 12, color: Colors.black))),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        const Icon(
                          FeatherIcons.mapPin,
                          size: 14,
                          color: Color(0xFFACA3A3),
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        Text("${doctorModel.distance}km",
                            style: GoogleFonts.manrope(
                              fontSize: 12,
                              color: const Color(0xFFACA3A3),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        Text(
                          "Available for",
                          style: GoogleFonts.manrope(
                              color: const Color(0xFF50CC98),
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                        const Spacer(),
                        SvgPicture.asset('assets/svgs/cat.svg'),
                        const SizedBox(
                          width: 10,
                        ),
                        SvgPicture.asset('assets/svgs/dog.svg'),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _services() {
    return SizedBox(
      height: 36,
      child: ListView.separated(
          itemBuilder: (context, index) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: selectedService == index
                        ? const Color(0xFF818AF9)
                        : const Color(0xFFF6F6F6),
                    border: selectedService == index
                        ? Border.all(
                            color: const Color(0xFFF1E5E5).withOpacity(.22),
                            width: 2)
                        : null,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      selectService(index, Service.all()[index]);
                    },
                    child: Text(
                      Service.all()[index],
                      style: GoogleFonts.manrope(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: selectedService == index
                            ? Colors.white
                            : const Color(0xFF3F3E3F).withOpacity(.3),
                      ),
                    ),
                  ),
                ),
              ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) => const SizedBox(
                width: 10,
              ),
          itemCount: Service.all().length),
    );
  }

  Container _search() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextFormField(
        decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: const Icon(
              FeatherIcons.search,
              color: Color(0xFFADACAD),
            ),
            hintText: "Find best vaccinate, treatment...",
            hintStyle: GoogleFonts.manrope(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFCACACA),
            )),
      ),
    );
  }

  AspectRatio _card() {
    return AspectRatio(
      aspectRatio: 336 / 184,
      child: Container(
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: const Color(0xFF818AF9),
        ),
        child: Stack(children: [
          Image.asset(
            'assets/images/background_card.png',
            height: double.maxFinite,
            width: double.maxFinite,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    text: TextSpan(
                        text: "Your ",
                        style: GoogleFonts.manrope(
                            fontSize: 14,
                            color: const Color(0xFFDEE1FE),
                            height: 150 / 100),
                        children: const [
                      TextSpan(
                          text: "Catrine ",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800)),
                      TextSpan(text: "will get\nvaccination "),
                      TextSpan(
                          text: "tomorrow \nat 07.00 am!",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800)),
                    ])),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.4),
                      border: Border.all(
                          color: Colors.white.withOpacity(.12), width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "See details",
                    style: GoogleFonts.manrope(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }

  Padding _greeting() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Hello, Human!",
              style: GoogleFonts.manrope(
                fontWeight: FontWeight.w800,
                fontSize: 22,
                color: const Color(0xFF3F3E3F),
              )),
          Stack(children: [
            IconButton(
                onPressed: () {},
                icon: const Icon(FeatherIcons.shoppingBag),
                color: const Color(0xFF818AF9)),
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                    color: const Color(0xFFEF6497),
                    borderRadius: BorderRadius.circular(15 / 2)),
                child: const Center(
                    child: Text(
                  "2",
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFFFFFFFF)),
                )),
              ),
            )
          ])
        ],
      ),
    );
  }
}
