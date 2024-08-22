import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/features/home/presentation/widget/set_location_order.dart';
import 'package:naqla/generated/l10n.dart';

class EndLocationCard extends StatelessWidget {
  const EndLocationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: context.colorScheme.outline),
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: REdgeInsets.all(10),
            child: AppText.subHeadMedium(S.of(context).end_point),
          ),
          SetLocationOrder(
            title: S.of(context).end_point,
            validator: (value) {
              if (value == null) {
                return S.of(context).the_end_point_must_be_determined;
              }
              return null;
            },
            name: 'endPoint',
          ),
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: AppTextFormField(
              name: 'street2',
              validator: FormBuilderValidators.required(
                  errorText: S.of(context).this_field_is_required),
              hintText: S.of(context).street,
            ),
          ),
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: AppTextFormField(
              validator: FormBuilderValidators.required(
                  errorText: S.of(context).this_field_is_required),
              name: 'region2',
              hintText: S.of(context).region,
            ),
          ),
        ],
      ),
    );
  }
}