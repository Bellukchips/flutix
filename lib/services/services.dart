import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutix/models/models.dart';
import 'package:flutix/shared/shared.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:flutix/extensions/extensions.dart';

part '../ui/page/auth/service/auth_services.dart';
part '../ui/page/auth/service/users_services.dart';
part '../ui/page/main/service/flutix_transaction_services.dart';
part '../ui/page/main/service/movie_service.dart';
part '../ui/page/main/service/tiket_services.dart';
