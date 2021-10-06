import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp/core/app_colors.dart';
import 'package:whatsapp/features/authentication/domain/entities/country.dart';
import 'package:whatsapp/features/authentication/presentation/cubit/country_cubit.dart';
import 'package:whatsapp/injection_contanier.dart';

class CountrySelector extends StatelessWidget {
  const CountrySelector({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CountryCubit>(),
      child: CountrySelectorView(),
    );
  }
}

class CountrySelectorView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    context.read<CountryCubit>().getCountries();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(
          color: Theme.of(context).primaryColor,
        ),
        bottom: PreferredSize(
          child: Container(
            color: Color(AppColors.lightGray),
            height: 1.0,
          ),
          preferredSize: Size.fromHeight(0),
        ),
        title: Text(
          'Escolha um país',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        actions: [
          IconButton(
            color: Theme.of(context).primaryColor,
            onPressed: () => {},
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<CountryCubit, CountryState>(
          builder: (context, state) {
            if (state is LoadingCountries) {
              return Text("Carregando");
            } else if (state is CountriesLoaded) {
              context
                  .read<CountryCubit>()
                  .sortListForBrazilianPortuguese(state.countries);
              return ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                separatorBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Divider(
                      height: 1,
                    ),
                  );
                },
                itemCount: state.countries.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, bottom: 20.0, left: 15.0, right: 50.0),
                      child: Row(
                        children: [
                          Text(
                            state.countries[index].countryEmoji,
                            style: TextStyle(fontSize: 20),
                          ),
                          Expanded(
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 15.0),
                                      child: Text(
                                        state.countries[index].translations.br,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        '+' +
                                            state.countries[index]
                                                .internationalCallingCodes[0],
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color(
                                              AppColors.intermediateDarkGray),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                state.countries[index].translations.br !=
                                        state.countries[index].nativeName
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15.0),
                                        child: Text(
                                          state.countries[index].nativeName,
                                          style: TextStyle(
                                            color: Color(
                                                AppColors.intermediateGray),
                                          ),
                                        ),
                                      )
                                    : Container()
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context, [
                        state.countries[index].translations.br,
                        state.countries[index].internationalCallingCodes[0]
                      ]);
                    },
                  );
                },
              );
            } else if (state is CountriesLoadingError) {
              return Text("Erro");
            }
            return Container();
          },
        ),
      ),
    );
  }
}
