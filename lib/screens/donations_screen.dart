import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:give_now/widgets/items_grid.dart';
import '../blocs/donation/donation_bloc.dart';
import '../blocs/donation/donation_state.dart';
import '../widgets/progress_loader.dart';

///
class DonationsScreen extends StatefulWidget {
  ///
  const DonationsScreen({Key key}) : super(key: key);

  @override
  _DonationsScreenState createState() => _DonationsScreenState();
}

class _DonationsScreenState extends State<DonationsScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(body:
          BlocBuilder<DonationBloc, DonationState>(builder: (context, state) {
        if (state is DonationsUpdated) {
          return state.currentUserDonations.isNotEmpty
              ? CustomScrollView(
                  slivers: [ItemsGrid(items: state.currentUserDonations)],
                )
              : const Center(
                  child: Text('No donations made yet.'),
                );
        }
        return const ProgressLoader();
      }));
}
