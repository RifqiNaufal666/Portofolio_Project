enum CreateEnum {
  edit,
  create;

  bool get isEdit => this == CreateEnum.edit;
  bool get isCreate => this == CreateEnum.create;
}
