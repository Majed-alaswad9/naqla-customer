import 'package:common_state/common_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla/core/common/constants/constants.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/core/di/di_container.dart';
import 'package:naqla/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla/features/app/presentation/widgets/params_appbar.dart';
import 'package:naqla/features/profile/presentation/pages/verification_update_phone_number_page.dart';
import 'package:naqla/features/profile/presentation/state/bloc/profile_bloc.dart';

import '../../../../generated/l10n.dart';

class EditPhoneNumberPage extends StatefulWidget {
  const EditPhoneNumberPage({super.key, required this.phone});
  final String phone;

  static String name = 'EditPhoneNumberPage';

  static String path = 'EditPhoneNumberPage';

  @override
  State<EditPhoneNumberPage> createState() => _EditPhoneNumberPageState();
}

class _EditPhoneNumberPageState extends State<EditPhoneNumberPage> {
  final GlobalKey<FormBuilderState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<ProfileBloc>(),
      child: AppScaffold(
          appBar: AppAppBar(appBarParams: AppBarParams(), back: true),
          body: Padding(
            padding: REdgeInsets.symmetric(vertical: UIConstants.screenPadding30, horizontal: UIConstants.screenPadding16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FormBuilder(
                  key: _key,
                  child: AppTextFormField(
                    initialValue: widget.phone,
                    title: S.of(context).your_mobile_number,
                    name: 'phoneNumber',
                    hintText: S.of(context).your_mobile_number,
                    keyboardType: TextInputType.phone,
                    valueTransformer: (value) {
                      String manimbulatedValue = '$value';
                      return manimbulatedValue;
                    },
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(10),
                    ]),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)],
                  ),
                ),
                30.verticalSpace,
                BlocSelector<ProfileBloc, ProfileState, CommonState>(
                  selector: (state) => state.getState(ProfileState.editPhoneNumber),
                  builder: (context, state) {
                    return AppButton.dark(
                      stretch: true,
                      isLoading: state.isLoading,
                      title: S.of(context).Save,
                      onPressed: () {
                        _key.currentState?.save();
                        _key.currentState?.validate();
                        if (_key.currentState?.isValid ?? false) {
                          context.read<ProfileBloc>().add(
                                UpdatePhoneNumberEvent(
                                  _key.currentState?.value['phoneNumber'],
                                  (p0) => context.pushNamed(
                                    VerificationUpdatePhonePage.name,
                                    extra: _key.currentState?.value['phoneNumber'],
                                  ),
                                ),
                              );
                        }
                      },
                    );
                  },
                )
              ],
            ),
          )),
    );
  }
}