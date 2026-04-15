import 'package:auth_flow_demo/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:auth_flow_demo/features/auth/presentation/bloc/auth_event.dart';
import 'package:auth_flow_demo/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(AuthLogoutRequested());
            },
          )
        ],
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if(state is AuthAuthenticated) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_outline, 
                    size: 100,
                    color: Colors.green
                  ),
                  SizedBox(height: 24),
                  Text('Welcome', style: TextStyle(
                    fontSize: 28, 
                    fontWeight: FontWeight.bold
                  )),
                  SizedBox(height: 16),
                  Text('Email: ${state.userEntity.email}'),
                  SizedBox(height: 16),
                  Text('Name: ${state.userEntity.name}'),
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}