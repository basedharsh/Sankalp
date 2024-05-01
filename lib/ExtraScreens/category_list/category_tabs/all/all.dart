import 'package:flutter/material.dart';

import '../../../../Widgets/search_page.dart';
import 'all_project/all_project.dart';

class All extends StatefulWidget {
  const All({super.key});

  @override
  State<All> createState() => _AllState();
}

class _AllState extends State<All> {
  final List<ItemData> itemList = [
    ItemData(
      imageUrl:
          'https://images.pexels.com/photos/2440337/pexels-photo-2440337.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      title: 'City Gardening',
      reviewCount: 145,
      description:
          """We're excited to offer a position for a City Gardener to help us transform urban spaces into green havens. As a City Gardener, your project involves beautifying public areas, parks, and streetscapes within our community. Your work will include planting and maintaining a variety of plants, trees, and flowers to enhance the visual appeal of our city. Join us in creating a more sustainable and vibrant urban environment.""",
      needDescription: """What We Need in a City Gardener
We are seeking a passionate and dedicated City Gardener who loves working with plants and has a deep understanding of horticulture. Your responsibilities will include planting, pruning, weeding, and overall landscape maintenance. You should have experience in landscaping and knowledge of urban gardening practices. If you have a green thumb, enjoy contributing to the beauty of urban spaces, and want to make a positive impact on our city's environment, we encourage you to apply. Become a part of our team and help us cultivate a greener and more inviting city for all residents to enjoy.""",
    ),
    ItemData(
      imageUrl:
          'https://images.unsplash.com/photo-1593113598332-cd288d649433?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
      title: 'Food Donation',
      reviewCount: 23,
      description:
          """Food donation is a compassionate and essential practice that involves the generous act of giving surplus or unneeded food to individuals or organizations in need. It is a remarkable way to address hunger, reduce food waste, and promote community well-being. Food donation embodies the principles of empathy, solidarity, and sustainability, making it a powerful force for positive change in society.

In essence, food donation is a powerful and meaningful way for individuals and communities to make a positive impact on the world. It addresses the pressing issues of hunger, food waste, and social cohesion, embodying the values of compassion, sustainability, and shared responsibility. It's a practice that not only nourishes bodies but also feeds the spirit of generosity and solidarity, making our world a better place for all.""",
      needDescription: """Nutritional Needs:
Access to a variety of nutritious foods to meet daily dietary requirements.
Consideration for dietary restrictions or preferences (e.g., allergies, religious beliefs, and cultural preferences).

Dignity and Respect:
A non-judgmental and respectful approach to receiving food assistance.
Empowerment to make food choices that align with personal values and needs.

Reliable Access:
Consistent access to food donations to mitigate food insecurity.
Knowledge of donation schedules and locations to plan accordingly.

Fresh and Healthy Options:
Availability of fresh fruits, vegetables, and perishable items in addition to non-perishable foods.
Assurance of food safety and quality standards.

Communication:
Clear and transparent communication channels between recipients and food donation organizations.
Feedback mechanisms to share suggestions and concerns.""", // Add description for this item
    ),
    ItemData(
      imageUrl:
          'https://images.pexels.com/photos/210922/pexels-photo-210922.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      title: 'Guitarist',
      reviewCount: 145,
      description:
          """Are you seeking the perfect melody to elevate your event or project? Look no further! Our skilled and versatile guitarist is ready to bring a harmonious touch to your musical needs. With a passion for creating soulful and captivating tunes, our guitarist brings years of experience and a diverse repertoire that spans various genres. From intimate gatherings to grand events, our guitarist adds a unique and unforgettable dimension to any occasion.""",
      needDescription:
          """Versatility: Our guitarist is well-versed in a wide range of musical genres, from classical and jazz to rock and pop. Whether you desire a serene acoustic ambiance or a lively, energetic performance, our guitarist can tailor their style to suit your preferences.

Professionalism: With a commitment to professionalism, our guitarist ensures punctuality, reliability, and a polished performance. They work closely with clients to understand the ambiance and mood desired, creating a musical experience that resonates with your vision.

Customization: Our guitarist understands that each event or project is unique. They collaborate with clients to curate a playlist that complements the theme, atmosphere, and preferences, ensuring a personalized and memorable musical experience.

Live Entertainment Expertise: Beyond technical proficiency, our guitarist brings an engaging stage presence, captivating audiences with their expressive and emotive performances. Whether it's a solo act, collaboration with other musicians, or part of a band, our guitarist knows how to create an immersive musical journey.""",
    ),
    ItemData(
      imageUrl:
          'https://img.freepik.com/free-photo/endowment-grantor-philanthropy-generosity-giving_53876-125192.jpg?w=996&t=st=1695800747~exp=1695801347~hmac=7ea75446c60aaa156f5ab3d1a4e2a3347225e53dbeea7c284a4282a8bc4d13c3',
      title: 'Philanthropy',
      reviewCount: 145,
      description:
          """We're excited to offer a position for a City Gardener to help us transform urban spaces into green havens. As a City Gardener, your project involves beautifying public areas, parks, and streetscapes within our community. Your work will include planting and maintaining a variety of plants, trees, and flowers to enhance the visual appeal of our city. Join us in creating a more sustainable and vibrant urban environment.""",
      needDescription: """What We Need in a City Gardener
We are seeking a passionate and dedicated City Gardener who loves working with plants and has a deep understanding of horticulture. Your responsibilities will include planting, pruning, weeding, and overall landscape maintenance. You should have experience in landscaping and knowledge of urban gardening practices. If you have a green thumb, enjoy contributing to the beauty of urban spaces, and want to make a positive impact on our city's environment, we encourage you to apply. Become a part of our team and help us cultivate a greener and more inviting city for all residents to enjoy.""",
    ),
    ItemData(
      imageUrl:
          'https://images.unsplash.com/photo-1593113598332-cd288d649433?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
      title: 'Food Donation',
      reviewCount: 23,
      description:
          """Food donation is a compassionate and essential practice that involves the generous act of giving surplus or unneeded food to individuals or organizations in need. It is a remarkable way to address hunger, reduce food waste, and promote community well-being. Food donation embodies the principles of empathy, solidarity, and sustainability, making it a powerful force for positive change in society.

In essence, food donation is a powerful and meaningful way for individuals and communities to make a positive impact on the world. It addresses the pressing issues of hunger, food waste, and social cohesion, embodying the values of compassion, sustainability, and shared responsibility. It's a practice that not only nourishes bodies but also feeds the spirit of generosity and solidarity, making our world a better place for all.""",
      needDescription: """Nutritional Needs:
Access to a variety of nutritious foods to meet daily dietary requirements.
Consideration for dietary restrictions or preferences (e.g., allergies, religious beliefs, and cultural preferences).

Dignity and Respect:
A non-judgmental and respectful approach to receiving food assistance.
Empowerment to make food choices that align with personal values and needs.

Reliable Access:
Consistent access to food donations to mitigate food insecurity.
Knowledge of donation schedules and locations to plan accordingly.

Fresh and Healthy Options:
Availability of fresh fruits, vegetables, and perishable items in addition to non-perishable foods.
Assurance of food safety and quality standards.

Communication:
Clear and transparent communication channels between recipients and food donation organizations.
Feedback mechanisms to share suggestions and concerns.""", // Add description for this item
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: itemList.length,
          itemBuilder: (context, index) {
            return AllItem(itemData: itemList[index]);
          },
        ),
      ),
    );
  }
}

class AllItem extends StatelessWidget {
  final ItemData itemData;

  const AllItem({super.key, required this.itemData});

  void _onReadMorePressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AllProjectsScreen(
          imageUrl: itemData.imageUrl,
          title: itemData.title,
          reviewCount: itemData.reviewCount,
          description: itemData.description, // Pass the description here
          needDescription: itemData.needDescription,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 200,
          child: Image.network(
            itemData.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    itemData.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons/location.png',
                        color: Colors.black,
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        "${itemData.reviewCount} reviews",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                itemData.description,
                style: const TextStyle(
                  color: Color.fromARGB(
                    255,
                    101,
                    100,
                    100,
                  ),
                ),
                maxLines: 5,
                overflow: TextOverflow.fade,
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    _onReadMorePressed(context);
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  child: const Text(
                    "Read more",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
