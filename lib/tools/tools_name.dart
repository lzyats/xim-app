import 'dart:math';

class ToolsName {
  // 单姓列表 - 常见武侠单姓
  static final List<String> _singleSurnames = [
    "李",
    "王",
    "张",
    "刘",
    "陈",
    "杨",
    "赵",
    "黄",
    "周",
    "吴",
    "徐",
    "孙",
    "马",
    "朱",
    "胡",
    "林",
    "郭",
    "何",
    "高",
    "罗",
    "郑",
    "梁",
    "谢",
    "宋",
    "唐",
    "许",
    "韩",
    "冯",
    "邓",
    "曹",
    "彭",
    "曾",
    "肖",
    "田",
    "董",
    "袁",
    "潘",
    "于",
    "蒋",
    "蔡",
    "余",
    "杜",
    "叶",
    "程",
    "苏",
    "魏",
    "吕",
    "丁",
    "任",
    "沈",
    "姚",
    "卢",
    "姜",
    "崔",
    "钟",
    "谭",
    "陆",
    "汪",
    "范",
    "金",
    "石",
    "廖",
    "贾",
    "夏",
    "韦",
    "付",
    "方",
    "白",
    "邹",
    "孟",
    "熊",
    "秦",
    "邱",
    "江",
    "尹",
    "薛",
    "闫",
    "段",
    "雷",
    "侯",
    "龙",
    "史",
    "陶",
    "黎",
    "贺",
    "顾",
    "毛",
    "郝",
    "龚",
    "邵"
  ];

  // 复姓列表 - 常见武侠复姓
  static final List<String> _compoundSurnames = [
    "欧阳",
    "太史",
    "端木",
    "上官",
    "司马",
    "东方",
    "独孤",
    "南宫",
    "万俟",
    "闻人",
    "夏侯",
    "诸葛",
    "尉迟",
    "公羊",
    "赫连",
    "澹台",
    "皇甫",
    "宗政",
    "濮阳",
    "公冶",
    "太叔",
    "申屠",
    "公孙",
    "慕容",
    "仲孙",
    "钟离",
    "长孙",
    "宇文",
    "司徒",
    "鲜于",
    "司空",
    "闾丘",
    "子车",
    "亓官",
    "司寇",
    "巫马",
    "公西",
    "颛孙",
    "壤驷",
    "公良",
    "漆雕",
    "乐正",
    "宰父",
    "谷梁",
    "拓跋",
    "夹谷",
    "轩辕",
    "令狐",
    "段干",
    "百里",
    "呼延",
    "东郭",
    "南门",
    "羊舌",
    "微生",
    "公户",
    "公玉",
    "公仪",
    "梁丘",
    "公仲",
    "公上",
    "公门",
    "公山",
    "公坚",
    "左丘",
    "公伯",
    "西门",
    "公祖",
    "第五",
    "公乘",
    "贯丘",
    "公皙",
    "南荣",
    "东里",
    "东宫",
    "仲长",
    "子书",
    "子桑",
    "即墨",
    "达奚",
    "褚师",
    "吴铭",
    "纳兰",
    "归海",
    "独孤",
    "慕容",
    "宇文",
    "司徒",
    "司空",
    "司马",
    "夏侯",
    "诸葛",
    "轩辕",
    "令狐",
    "段干",
    "百里",
    "东郭",
    "南门",
    "呼延",
    "欧阳"
  ];

  // 武侠风格名字列表
  static final List<String> _maleFirstNames = [
    "大侠",
    "剑客",
    "刀客",
    "镖师",
    "侠客",
    "奇侠",
    "剑侠",
    "少侠",
    "豪杰",
    "义士",
    "忠良",
    "英雄",
    "枭雄",
    "霸主",
    "尊者",
    "掌门",
    "宗师",
    "盟主",
    "剑仙",
    "刀圣",
    "枪神",
    "箭神",
    "棍王",
    "鞭王",
    "暗器",
    "神捕",
    "捕快",
    "杀手",
    "刺客",
    "琴魔",
    "棋圣",
    "书痴",
    "画狂",
    "神医",
    "毒仙",
    "神丐",
    "隐侠",
    "狂生",
    "醉汉",
    "书生",
    "秀才",
    "公子",
    "少爷",
    "员外",
    "壮士",
    "武师",
    "教头",
    "武士",
    "侍卫",
    "护卫",
    "保镖",
    "统领",
    "将军",
    "元帅",
    "军师",
    "谋士",
    "大侠",
    "剑客",
    "刀客",
    "镖师",
    "侠客",
    "奇侠",
    "剑侠",
    "少侠",
    "豪杰",
    "义士",
    "忠良",
    "英雄",
    "枭雄",
    "霸主",
    "尊者",
    "掌门",
    "宗师",
    "盟主",
    "剑仙",
    "刀圣",
    "枪神",
    "箭神",
    "棍王"
  ];

  static final List<String> _femaleFirstNames = [
    "侠女",
    "女侠",
    "剑姬",
    "刀姬",
    "镖娘",
    "侠娘",
    "奇侠",
    "剑仙",
    "仙姑",
    "侠姑",
    "义妹",
    "忠良",
    "英雌",
    "枭姬",
    "霸主",
    "尊者",
    "掌门",
    "宗师",
    "盟主",
    "剑仙",
    "刀圣",
    "琴仙",
    "棋妙",
    "书慧",
    "画娇",
    "神医",
    "毒姬",
    "神丐",
    "隐侠",
    "狂女",
    "醉姑",
    "淑女",
    "秀女",
    "闺秀",
    "千金",
    "郡主",
    "夫人",
    "少夫人",
    "娘子",
    "姑娘",
    "小姐",
    "侠女",
    "女侠",
    "剑姬",
    "刀姬",
    "镖娘",
    "侠娘",
    "奇侠",
    "剑仙",
    "仙姑",
    "侠姑",
    "义妹",
    "忠良",
    "英雌",
    "枭姬",
    "霸主",
    "尊者",
    "掌门",
    "宗师",
    "盟主",
    "剑仙",
    "刀圣",
    "琴仙",
    "棋妙",
    "书慧",
    "画娇",
    "神医",
    "毒姬",
    "神丐",
    "隐侠",
    "狂女",
    "醉姑"
  ];

  static final List<String> _unisexFirstNames = [
    "风",
    "云",
    "雷",
    "电",
    "雨",
    "雪",
    "霜",
    "雾",
    "星",
    "月",
    "日",
    "光",
    "明",
    "暗",
    "黑",
    "白",
    "龙",
    "虎",
    "狮",
    "豹",
    "熊",
    "鹰",
    "鹤",
    "蛇",
    "蝎",
    "狼",
    "狐",
    "鹿",
    "马",
    "牛",
    "羊",
    "犬",
    "剑",
    "刀",
    "枪",
    "棍",
    "棒",
    "鞭",
    "锤",
    "斧",
    "钩",
    "叉",
    "戟",
    "弓",
    "箭",
    "弩",
    "镖",
    "刃",
    "雄",
    "霸",
    "豪",
    "杰",
    "英",
    "俊",
    "伟",
    "武",
    "勇",
    "猛",
    "刚",
    "强",
    "毅",
    "坚",
    "韧",
    "狂",
    "冷",
    "傲",
    "孤",
    "独",
    "寂",
    "寞",
    "忧",
    "伤",
    "愁",
    "恨",
    "怨",
    "怒",
    "狂",
    "癫",
    "疯",
    "痴",
    "清",
    "静",
    "空",
    "明",
    "虚",
    "无",
    "真",
    "善",
    "美",
    "仁",
    "义",
    "礼",
    "智",
    "信",
    "忠",
    "孝",
    "天",
    "地",
    "玄",
    "黄",
    "宇",
    "宙",
    "洪",
    "荒",
    "日",
    "月",
    "星",
    "辰",
    "山",
    "河",
    "湖",
    "海",
    "春",
    "夏",
    "秋",
    "冬",
    "晨",
    "昏",
    "昼",
    "夜",
    "寒",
    "暑",
    "炎",
    "凉",
    "温",
    "柔",
    "刚",
    "烈"
  ];

  static final Random _random = Random();

  /**
   * 生成随机武侠风格姓名
   * @return 武侠风格姓名
   */
  static String generateRandomName() {
    // 随机决定姓名长度（2-4字）
    final int nameLength = _random.nextInt(3) + 2; // 2, 3, 4

    // 根据长度决定使用单姓/复姓和名字数量
    if (nameLength == 2) {
      // 单姓 + 1个字名
      return _generateSingleSurnameName(1);
    } else if (nameLength == 3) {
      // 随机单姓 + 2个字名 或 复姓 + 1个字名
      if (_random.nextBool()) {
        return _generateSingleSurnameName(2);
      } else {
        return _generateCompoundSurnameName(1);
      }
    } else {
      // 复姓 + 2个字名
      return _generateCompoundSurnameName(2);
    }
  }

  /**
   * 生成指定字数的单姓姓名
   * @param firstNameLength 名的字数
   * @return 姓名
   */
  static String _generateSingleSurnameName(int firstNameLength) {
    final String surname = _getRandomElement(_singleSurnames)!;
    final String firstName = _generateFirstName(firstNameLength);
    return surname + firstName;
  }

  /**
   * 生成指定字数的复姓姓名
   * @param firstNameLength 名的字数
   * @return 姓名
   */
  static String _generateCompoundSurnameName(int firstNameLength) {
    final String surname = _getRandomElement(_compoundSurnames)!;
    final String firstName = _generateFirstName(firstNameLength);
    return surname + firstName;
  }

  /**
   * 生成指定长度的名字
   * @param length 名字长度
   * @return 生成的名字
   */
  static String _generateFirstName(int length) {
    final StringBuffer name = StringBuffer();
    for (int i = 0; i < length; i++) {
      name.write(_getRandomElement(_unisexFirstNames));
    }
    return name.toString();
  }

  /**
   * 从列表中获取随机元素
   * @param list 列表
   * @return 随机元素
   */
  static T? _getRandomElement<T>(List<T> list) {
    if (list.isEmpty) {
      return null;
    }
    return list[_random.nextInt(list.length)];
  }

  /**
   * 生成多个随机武侠风格姓名
   * @param count 生成数量
   * @return 姓名列表
   */
  static List<String> generateNames(int count) {
    final List<String> names = [];
    for (int i = 0; i < count; i++) {
      names.add(generateRandomName());
    }
    return names;
  }

  /**
   * 打乱单姓列表顺序
   */
  static void shuffleSingleSurnames() {
    _singleSurnames.shuffle(_random);
  }

  /**
   * 打乱复姓列表顺序
   */
  static void shuffleCompoundSurnames() {
    _compoundSurnames.shuffle(_random);
  }

  /**
   * 打乱名字列表顺序
   */
  static void shuffleFirstNames() {
    _unisexFirstNames.shuffle(_random);
  }
}
